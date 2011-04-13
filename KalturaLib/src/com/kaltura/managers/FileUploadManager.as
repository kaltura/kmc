package com.kaltura.managers {
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.flavorAsset.FlavorAssetAdd;
	import com.kaltura.commands.flavorAsset.FlavorAssetUpdate;
	import com.kaltura.commands.media.MediaConvert;
	import com.kaltura.commands.media.MediaUpdate;
	import com.kaltura.commands.uploadToken.UploadTokenAdd;
	import com.kaltura.commands.uploadToken.UploadTokenDelete;
	import com.kaltura.commands.uploadToken.UploadTokenUpload;
	import com.kaltura.events.FileUploadEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.FileUploadVO;
	import com.kaltura.vo.KalturaAssetParamsResourceContainer;
	import com.kaltura.vo.KalturaAssetsParamsResourceContainers;
	import com.kaltura.vo.KalturaFlavorAsset;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaUploadToken;
	import com.kaltura.vo.KalturaUploadedFileTokenResource;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	/**
	 * This class will handle all file uploads for the current KMC session
	 * @author Atar
	 */
	public class FileUploadManager extends EventDispatcher {


		/**
		 * Singleton instance
		 */
		private static var _instance:FileUploadManager;

		/**
		 * @copy concurrentUploads
		 */
		private var _concurrentUploads:int = 3;

		/**
		 * list of files schedualed for upload
		 */
		private var _files:Vector.<FileUploadVO>;
		
		/**
		 * a list of files that uploaded successfully and are part of a group 
		 */
		private var _groupAndComplete:Vector.<FileUploadVO>;

		/**
		 * @copy #kc 
		 */
		private var _kc:KalturaClient;

		
		/**
		 * Singleton constructor.
		 * @param enforcer
		 */
		public function FileUploadManager(enforcer:Enforcer) {
			_files = new Vector.<FileUploadVO>();
			_groupAndComplete = new Vector.<FileUploadVO>();
		}
		
		
		/**
		 * Retrieves the singleton instance
		 */
		public static function getInstance():FileUploadManager {
			if (_instance == null) {
				_instance = new FileUploadManager(new Enforcer());
			}
			return _instance;
		}


		/**
		 * Adds an upload to the queue.
		 *
		 * <p><u>General upload process:</u>
		 * Create upload token (uploadToken.add)
		 * Upload file (uploadToken.upload)
		 * dispatch "fileUploadComplete" event with relevant unique identifier
		 * if any action on the VO trigger flavorAsset.action
		 * if (file.groupid != null) {
		 * 	add the file to a group_and_complete list
		 * 	scan rest of files.
		 * 	if no other file has the same groupid {
		 * 		dispatch "groupUploadComplete" event with group identifier
		 * 		if action = add on the VO trigger media.convert for the entry
		 * 		else {
		 * 			trigger media.update with all group resources from the group_and_complete list.
		 * 			remove relevant files from the group_and_complete list.
		 * 		}
		 * 	}
		 * }
		 * remove file from files list </p>
		 *
		 * @param entryid	the id of the entry to which this file will be added
		 * @param file		the file to upload
		 * @param action	the action to apply on the file after upload, either
		 * 		<code>UploadFileVO.ADD</code>, <code>UploadFileVO.UPDATE</code>
		 * 		or <code>UploadFileVO.NONE</code>
		 * @param flavorid	if updating an entry, the flavourAsset that should be 
		 * 		replaced. if adding assets to a no_content entry, the flavorParam 
		 * 		to be used with this asset.
		 * @param groupid	identifier of a flavour group. if <code>groupid</code>
		 * 		is supplied, media.update will be triggered after all files with
		 * 		this group id have finished uploading.
		 *
		 * @return a unique identifier for the upload, which allows referencing the
		 * 		upload process of the specific file
		 */
		public function addUpload(entryid:String, file:FileReference, action:String, 
							flavorparamsid:String = null, flavorassetid:String = null, 
							convprofid:String = null, groupid:String = null):String {
			// create the VO
			var vo:FileUploadVO = new FileUploadVO();
			vo.file = file;
			vo.name = file.name;
			vo.uploadTime = new Date();
			vo.entryId = entryid; 
			vo.groupId = groupid;
			vo.flavorParamsId = parseInt(flavorparamsid);
			vo.conversionProfile = convprofid;
			vo.fileSize = file.size;
			vo.action = action;
			_files.push(vo);
			if (_files.length < _concurrentUploads) {
				uploadNextFile();
			}
			return vo.id;
		}
		
		/**
		 * get the next file on uploads queue 
		 */
		private function getNextFile():FileUploadVO {
			var result:FileUploadVO = null;
			for (var i:int = 0; i<_files.length; i++) {
				if (_files[i].status == FileUploadVO.STATUS_QUEUED) {
					result = _files[i];
					break;
				}
			}
			return result;
		}
		
		
		/**
		 * upload the next file on queue 
		 */		
		private function uploadNextFile():void {
			var vo:FileUploadVO = getNextFile();
			if (vo) {
				vo.status = FileUploadVO.STATUS_UPLOADING;
				// create upload token
				var ut:KalturaUploadToken = new KalturaUploadToken();
				ut.fileName = vo.name;
				ut.fileSize = vo.fileSize;
				var uta:UploadTokenAdd = new UploadTokenAdd(ut); 
				// add listeners for complete / failed
				uta.addEventListener(KalturaEvent.COMPLETE, uploadFile);
				uta.addEventListener(KalturaEvent.FAILED, uploadFile);
				_kc.post(uta);
			}
		}
		
		/**
		 * start uploading the file  
		 */
		private function uploadFile(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, uploadFile);
			e.target.removeEventListener(KalturaEvent.FAILED, uploadFile);
			if (e.type == KalturaEvent.COMPLETE) {
				// uploadToken.upload
				var token:KalturaUploadToken = e.data as KalturaUploadToken;
				var file:FileUploadVO = getUploadByFileName(token.fileName);
				file.uploadToken = token.id;
				var utu:UploadTokenUpload = new UploadTokenUpload(token.id, file.file);
				utu.queued = false;
				// add listeners with weak references because if upload fails, we can't clean them manually
				utu.addEventListener(KalturaEvent.COMPLETE, wrapUpUpload, false, 0, true);
				utu.addEventListener(KalturaEvent.FAILED, wrapUpUpload, false, 0, true);
				file.file.addEventListener(IOErrorEvent.IO_ERROR, fileFailed );
				file.file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, fileFailed);
				_kc.post(utu);
			}
			else {
				// alert user
				showError(e.error.errorMsg);
			}
		}
	
	
		/**
		 * apply the action specified for the uploaded file and handle group completion 
		 */
		private function wrapUpUpload(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, wrapUpUpload);
			e.target.removeEventListener(KalturaEvent.FAILED, wrapUpUpload);
			var file:FileUploadVO = getUploadByUploadToken(e.data.id);
			if (e.type == KalturaEvent.COMPLETE) {
				file.status = FileUploadVO.STATUS_COMPLETE;
				// dispatch "fileUploadComplete" event with relevant unique identifier
				dispatchEvent(new FileUploadEvent(FileUploadEvent.UPLOAD_COMPLETE, file.id));
				if (file.groupId) {
					// add the file to a group_and_complete list
					_groupAndComplete.push(file);
					// if no other actions was specified, handle group issues
					if (file.action == FileUploadVO.ACTION_NONE) {
						handleGroupFile(file);
					}
				}
				// if any action on the VO trigger flavorAsset.action
				var flavorAsset:KalturaFlavorAsset;
				var resource:KalturaUploadedFileTokenResource
				if (file.action == FileUploadVO.ACTION_ADD) {
					addFlavorAsset(file);
				}
				else if (file.action == FileUploadVO.ACTION_UPDATE) {
					updateFlavorAsset(file);
				}
				// remove file from files list 
				var ind:int = getQueuePosition(file.id);
				_files.splice(ind, 1);
			}
			else {
				file.status = FileUploadVO.STATUS_FAILED;
				showError(e.error.errorMsg);
			}
			// start uploading the next file
			uploadNextFile();
		}
		
		
		/**
		 * save the file to the groups list, and if the group is complete 
		 * finish processing it.  
		 * @param file	the file 
		 */		
		private function handleGroupFile(file:FileUploadVO):void {
			// scan rest of files.
			var remainingGroupFiles:Boolean = false;
			for each (var notYet:FileUploadVO in _files) {
				if (notYet == file) continue;	// the file is removed from the list only afterwards
					
				if (notYet.groupId == file.groupId) {
					remainingGroupFiles = true;
					break;
				}
			}
			//	if no other file has the same groupid 
			if (!remainingGroupFiles) {
				//	dispatch "groupUploadComplete" event with group identifier
				dispatchEvent(new FileUploadEvent(FileUploadEvent.GROUP_UPLOAD_COMPLETE, file.groupId));
				if (file.action == FileUploadVO.ACTION_ADD) {
					// trigger media.convert for the entry
					var mc:MediaConvert = new MediaConvert(file.entryId, parseInt(file.conversionProfile));
					mc.addEventListener(KalturaEvent.COMPLETE, finalActionHandler);
					mc.addEventListener(KalturaEvent.FAILED, finalActionHandler);
					_kc.post(mc);
				}
				else if (file.action == FileUploadVO.ACTION_NONE) {
					updateMedia(file.groupId, file.entryId);
				}
			}
		}
		
		
		/**
		 * trigger media.update with all group resources from the group_and_complete list. 
		 * @param groupid	common id of the files in the group 
		 * @param entryid	id of the entry that will be replaced by the entry created 
		 * 					with these files
		 */
		private function updateMedia(groupid:String, entryid:String):void {
			// the media entry we will update (no need for entryid as it's read-only)
			var mediaEntry:KalturaMediaEntry = new KalturaMediaEntry();
			//TODO - make sure we don't need a real entry here!! (if possible, pass in null)
			
			// the actual resource we send is a list of the containers for the resources we want to replace.                
			var mediaResource:KalturaAssetsParamsResourceContainers = new KalturaAssetsParamsResourceContainers();
			mediaResource.resources = new Array();
			
			for each (var grpFile:FileUploadVO in _groupAndComplete) {
				if (grpFile.groupId == groupid) {
					// the first resource of the flavor we want to replace
					var subSubResource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
					subSubResource.token = grpFile.uploadToken;	// the token we used to upload the file
					
					// container for the resource we want to replace
					var subResource:KalturaAssetParamsResourceContainer = new KalturaAssetParamsResourceContainer();
					subResource.resource = subSubResource;
					subResource.assetParamsId = grpFile.flavorParamsId;
					
					// add to list
					mediaResource.resources.push(subResource);
				}
				
			}
			var mu:MediaUpdate = new MediaUpdate(entryid, mediaEntry, mediaResource);
			mu.addEventListener(KalturaEvent.COMPLETE, finalActionHandler);
			mu.addEventListener(KalturaEvent.FAILED, finalActionHandler);
			_kc.post(mu);
			
			// remove relevant files from the group_and_complete list.
			removeGroupFromCompleteList(groupid);
		}
		
		
		
		/**
		 * removes all fiels that have the given group identifier 
		 * from the completed uploads list 
		 * @param groupid	group identifier
		 */
		private function removeGroupFromCompleteList(groupid:String):void {
			for (var i:int = _groupAndComplete.length-1; i >= 0; i--) {
				if (_groupAndComplete[i].groupId == groupid) {
					_groupAndComplete.splice(i, 1);
				}
			}
		}
		
		
		/**
		 * update a single flavor asset, without creating replacement entry 
		 * @param file
		 */
		private function updateFlavorAsset(file:FileUploadVO):void {
			// we don’t need flavorParamsId here
			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset();
			var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
			// the token we used to upload the file
			resource.token = file.uploadToken;	
			var fau:FlavorAssetUpdate = new FlavorAssetUpdate(file.flavorAssetId, flavorAsset, resource);
			fau.addEventListener(KalturaEvent.COMPLETE, flavorActionHandler);
			fau.addEventListener(KalturaEvent.FAILED, flavorActionHandler);
			_kc.post(fau);
		}

		
		/**
		 * add a single flavor asset to a no-media entry 
		 * @param file
		 */		
		private function addFlavorAsset(file:FileUploadVO):void {
			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset();
			// the flavorParamsId of the flavor we want this to be
			flavorAsset.flavorParamsId = file.flavorParamsId;	
			var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
			// the token we used to upload the file
			resource.token = file.uploadToken;	
			var faa:FlavorAssetAdd = new FlavorAssetAdd(file.entryId, flavorAsset, resource);
			faa.addEventListener(KalturaEvent.COMPLETE, flavorActionHandler);
			faa.addEventListener(KalturaEvent.FAILED, flavorActionHandler);
			_kc.post(faa);
		}
		
		
		/**
		 * 
		 * alert user of any problems 
		 */		
		private function flavorActionHandler(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, flavorActionHandler);
			e.target.removeEventListener(KalturaEvent.FAILED, flavorActionHandler);
			if (e.type == KalturaEvent.FAILED) {
				// alert user
				showError(e.error.errorMsg);
			}
			else {
				var file:FileUploadVO = getCompleteByFlavorAssetId(e.data.flavorParamsId);
				if (file.groupId != null) {
					handleGroupFile(file);
				}				
			}
		}
		
		
		/**
		 * handler for the wrap-up action (flavorAsset.add / update)
		 * alert user of any problems 
		 */		
		private function finalActionHandler(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, finalActionHandler);
			e.target.removeEventListener(KalturaEvent.FAILED, finalActionHandler);
			if (e.type == KalturaEvent.FAILED) {
				// alert user
				showError(e.error.errorMsg);
			}
		}
		
		protected function showError(str:String):void {
			Alert.show(str, ResourceManager.getInstance().getString('cms', 'error'));
		}
		
		
		/**
		 * handler for security error or io error 
		 */		
		private function fileFailed(e:Event):void {
			// clean listeners
			var file:FileReference = e.target as FileReference;
			file.removeEventListener(IOErrorEvent.IO_ERROR, fileFailed );
			file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, fileFailed);
			var fuv:FileUploadVO = getUploadByFr(file);
			if (fuv) {
				fuv.status = FileUploadVO.STATUS_FAILED;
			}
			// alert user (possible to separate to ioerror / security error)
			showError(ResourceManager.getInstance().getString('cms', 'uploadFailedMessage'));
		}

		

		/**
		 * Cancels an upload according to uploadid.
		 *
		 * @param uploadid
		 */
		public function cancelUpload(uploadid:String):void {
			var file:FileUploadVO = getFile(uploadid);
			if (!file) {
				return;
			}
			//	call uploadToken.delete with relevant upload token.
			var utd:UploadTokenDelete = new UploadTokenDelete(file.uploadToken);
			utd.addEventListener(KalturaEvent.COMPLETE, handleDeleteResult);
			utd.addEventListener(KalturaEvent.FAILED, handleDeleteResult);
			_kc.post(utd);
			// Dispatch "fileUploadCanceled" event.
			dispatchEvent(new FileUploadEvent(FileUploadEvent.UPLOAD_CANCELED, uploadid));
			// Remove relevant fileVo from files list.	
			var ind:int = getQueuePosition(uploadid);
			_files.splice(ind, 1);
		}
		
		
		/**
		 * remove delete listeners, handle error. 
		 */
		private function handleDeleteResult(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, handleDeleteResult);
			e.target.removeEventListener(KalturaEvent.FAILED, handleDeleteResult);
			if (e.type == KalturaEvent.FAILED) {
				showError(e.error.errorMsg);
			}
		}
		
		
		/**
		 * Retrieve a file vo according to its file reference object 
		 * @param id	file reference
		 * @return 		FileUploadVO 
		 */		
		public function getUploadByFr(o:FileReference):FileUploadVO {
			var result:FileUploadVO = null;
			for each (var file:FileUploadVO in _files) {
				if (file.file == o) {
					result = file;
					break;
				}
			}
			return result;
		}
		
		
		/**
		 * Retrieve a file vo according to uploadToken 
		 * @param id	uploadToken id
		 * @return 		FileUploadVO 
		 */		
		public function getUploadByUploadToken(id:String):FileUploadVO {
			var result:FileUploadVO = null;
			for each (var file:FileUploadVO in _files) {
				if (file.uploadToken == id) {
					result = file;
					break;
				}
			}
			return result;
		}
		
		
		/**
		 * Retrieve a file vo according to file name 
		 * @param name	name of the uploaded file
		 * @return 		FileUploadVO with a file with a matching name
		 */		
		public function getUploadByFileName(name:String):FileUploadVO {
			var result:FileUploadVO = null;
			for each (var file:FileUploadVO in _files) {
				if (file.name == name) {
					result = file;
					break;
				}
			}
			return result;
		}
		
		
		public function getCompleteByFlavorAssetId(id:int):FileUploadVO {
			var result:FileUploadVO = null;
			for each (var file:FileUploadVO in _groupAndComplete) {
				if (file.flavorParamsId == id) {
					result = file;
					break;
				}
			}
			return result;
		}


		/**
		 * Get the position in the queue of a certain upload
		 *
		 * @param uploadid	id of the requested upload
		 *
		 * @return 	index of the upload in the uploads queue, or -1 if not found
		 */
		public function getQueuePosition(uploadid:String):int {
			var result:int = -1;
			for (var i:int = 0; i < _files.length; i++) {
				if (_files[i].id == uploadid) {
					result = i;
					break;
				}
			}
			return result;
		}


		/**
		 * Tries to move the referenced Vo to the supplied index.
		 * Uploads that are further down the queue will be pushed down.
		 *
		 * @param uploadid	id of the requested upload
		 * @param requiredIndex	the index to move the upload to.
		 *
		 * @return 	true if move succeeded, false otherwise (i.e. illegal index).
		 */
		public function setQueuePosition(uploadid:String, requiredIndex:int):Boolean {
			if (requiredIndex > _files.length) {
				return false;
			}
			var ind:int = getQueuePosition(uploadid);
			if (ind == -1) {
				return false;
			}
			var file:FileUploadVO = getFile(uploadid);
			_files.splice(ind, 1);
			_files.splice(requiredIndex, 0, file);
			return true;
		}


		/**
		 * Retrieve a file vo from the list.
		 *
		 * @param uploadid	id of the requested upload
		 *
		 * @return the file Vo referenced by the uploadid supplied, or null if not found
		 */
		public function getFile(uploadid:String):FileUploadVO {
			var result:FileUploadVO = null;
			for each (var file:FileUploadVO in _files) {
				if (file.id == uploadid) {
					result = file;
					break;
				}
			}
			return result;
		}


		/**
		 * Retrieve all fileVos currently queued.
		 * Used for creating the dataprovider of the uploads tab.
		 *
		 * @return a vector of FileVo-s.
		 * 		references are to the actual objects, not to clones.
		 */
		public function getAllFiles():Vector.<FileUploadVO> {
			return _files;
		}


		/**
		 * Determines the number of simultaneous uploads
		 */
		public function get concurrentUploads():int {
			return _concurrentUploads;
		}


		/**
		 * @private
		 */
		public function set concurrentUploads(value:int):void {
			_concurrentUploads = value;
		}


		/**
		 * client for API requests
		 */
		public function get kc():KalturaClient {
			return _kc;
		}


		/**
		 * @private
		 */
		public function set kc(value:KalturaClient):void {
			_kc = value;
		}


	}
}

class Enforcer {

}