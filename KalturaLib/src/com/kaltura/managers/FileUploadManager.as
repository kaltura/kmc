package com.kaltura.managers {
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.flavorAsset.FlavorAssetAdd;
	import com.kaltura.commands.flavorAsset.FlavorAssetUpdate;
	import com.kaltura.commands.media.MediaAddContent;
	import com.kaltura.commands.media.MediaConvert;
	import com.kaltura.commands.media.MediaUpdate;
	import com.kaltura.commands.media.MediaUpdateContent;
	import com.kaltura.commands.uploadToken.UploadTokenAdd;
	import com.kaltura.commands.uploadToken.UploadTokenDelete;
	import com.kaltura.commands.uploadToken.UploadTokenUpload;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.FileUploadEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.net.KalturaCall;
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
	import flash.utils.Dictionary;
	
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
		 * files that are not ready for upload yet 
		 * (tokens not created or not added to entry) 
		 */		
		private var _preprocessedFiles:Vector.<FileUploadVO>;
		

		/**
		 * list of files schedueled for upload
		 */
		private var _files:Vector.<FileUploadVO>;
		

		/**
		 * @copy #kc 
		 */
		private var _kc:KalturaClient;

		
		/**
		 * Singleton constructor.
		 * @param enforcer
		 */
		public function FileUploadManager(enforcer:Enforcer) {
			_preprocessedFiles = new Vector.<FileUploadVO>();
			_files = new Vector.<FileUploadVO>();
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


//		/**
//		 * Adds an upload to the queue.
//		 *
//		 * <p><u>General upload process:</u>
//		 * Create upload token (uploadToken.add)
//		 * Upload file (uploadToken.upload)
//		 * dispatch "fileUploadComplete" event with relevant unique identifier
//		 * if any action on the VO trigger flavorAsset.action
//		 * if (file.groupid != null) {
//		 * 	add the file to a group_and_complete list
//		 * 	scan rest of files.
//		 * 	if no other file has the same groupid {
//		 * 		dispatch "groupUploadComplete" event with group identifier
//		 * 		if action = add on the VO trigger media.convert for the entry
//		 * 		else {
//		 * 			trigger media.update with all group resources from the group_and_complete list.
//		 * 			remove relevant files from the group_and_complete list.
//		 * 		}
//		 * 	}
//		 * }
//		 * remove file from files list </p>
//		 *
//		 * @param entryid	the id of the entry to which this file will be added
//		 * @param file		the file to upload
//		 * @param action	the action to apply on the file after upload, either
//		 * 		<code>UploadFileVO.ADD</code>, <code>UploadFileVO.UPDATE</code>
//		 * 		or <code>UploadFileVO.NONE</code>
//		 * @param flavorid	if updating an entry, the flavourAsset that should be 
//		 * 		replaced. if adding assets to a no_content entry, the flavorParam 
//		 * 		to be used with this asset.
//		 * @param groupid	identifier of a flavour group. if <code>groupid</code>
//		 * 		is supplied, media.update will be triggered after all files with
//		 * 		this group id have finished uploading.
//		 *
//		 * @return a unique identifier for the upload, which allows referencing the
//		 * 		upload process of the specific file
//		 */
//		public function addUpload(entryid:String, file:FileReference, action:String, 
//							flavorparamsid:String = null, flavorassetid:String = null, 
//							convprofid:String = null, groupid:String = null):String {
//			// create the VO
//			var vo:FileUploadVO = new FileUploadVO();
//			vo.file = file;
//			vo.name = file.name;
//			vo.uploadTime = new Date();
//			vo.entryId = entryid; 
//			vo.groupId = groupid;
//			vo.flavorParamsId = parseInt(flavorparamsid);
//			vo.flavorAssetId = flavorassetid;
//			vo.conversionProfile = convprofid;
//			vo.fileSize = file.size;
//			vo.action = action;
//			_files.push(vo);
//			if (_files.length < _concurrentUploads) {
//				uploadNextFile();
//			}
//			return vo.id;
//		}
		
		public function createFuv(entryid:String, file:FileReference, 
	  							flavorparamsid:String = null, flavorassetid:String = null, 
	  							convprofid:String = null):FileUploadVO {
			// create the VO
			var vo:FileUploadVO = new FileUploadVO();
			vo.file = file;
			vo.name = file.name;
			vo.uploadTime = new Date();
			vo.entryId = entryid; 
			vo.flavorParamsId = parseInt(flavorparamsid);
			vo.flavorAssetId = flavorassetid;
			vo.conversionProfile = convprofid;
			vo.fileSize = file.size;
			
			return vo;
		}
		
		
		
		
		
		/**
		 * add media files to a no_content entry 
		 * @param entryid	the id of the entry to be updated
		 * @param filesData array of FileUploadVo
		 * @param isOrphan	is this the initial content adding to this entry
		 */
		public function updateEntryContent(entryid:String, filesData:Array, isOrphan:Boolean):void {
			/*
			- create all required tokens
			- add them to the media
			- start uploading the files
			*/
			var mr:MultiRequest = new MultiRequest();
			var uta:UploadTokenAdd;
			var ut:KalturaUploadToken;
			var vo:FileUploadVO;
			for (var i:int = 0; i<filesData.length; i++) {
				vo = filesData[i];
				_preprocessedFiles.push(vo);
				// create upload token
				ut = new KalturaUploadToken();
				ut.fileName = vo.name;
				ut.fileSize = vo.fileSize;
				uta = new UploadTokenAdd(ut);
				mr.addAction(uta);
			}
			// add listeners for complete / failed
			// pass events via fuv so we can retrieve a relevant vo after the call returns.
			vo.addEventListener(KalturaEvent.COMPLETE, addContent/*, false, 0, true*/);
			vo.addEventListener(KalturaEvent.FAILED, addContent/*, false, 0, true*/);
			// another ugly misuse:
			vo.orphan = isOrphan;
			
			mr.addEventListener(KalturaEvent.COMPLETE, vo.bubbleEvent);
			mr.addEventListener(KalturaEvent.FAILED, vo.bubbleEvent);
			_kc.post(mr);
		}
		
		
		/**
		 * add the received tokens to the specified media entry
		 * @param e
		 */		
		protected function addContent(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, addContent);
			e.target.removeEventListener(KalturaEvent.FAILED, addContent);
			if (e.type == KalturaEvent.COMPLETE) {
				// e.target is a good vo. e.data is the multirequest response
				// add the uploadTokens to the VOs
				var ut:KalturaUploadToken;
				var file:FileUploadVO;
				for each (var o:Object in e.data) {
					if (o is KalturaUploadToken) {
						ut = o as KalturaUploadToken;
						file = getVoByFileName(ut.fileName);
						file.uploadToken = ut.id;
					}
					else if (o is KalturaError) {
						//TODO something that breaks the chain
					}
				}
				
				file = e.target as FileUploadVO;
				// create uploadTokenResources, add them to the media.
				var entryid:String = file.entryId;  // id of the entry that will be replaced by the entry created with these files
				// the media entry we will update (no need for entryid as it's read-only)
				var mediaEntry:KalturaMediaEntry = new KalturaMediaEntry();
				
				// the actual resource we send is a list of the containers for the resources we want to replace.                
				var mediaResource:KalturaAssetsParamsResourceContainers = new KalturaAssetsParamsResourceContainers();
				mediaResource.resources = new Array();
				
				for each (file in _preprocessedFiles) {
					if (file.entryId == entryid) {
						// the first resource of the flavor we want to replace
						var subSubResource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
						subSubResource.token = file.uploadToken;	// the token used to upload the file
						
						// container for the resource we want to replace
						var subResource:KalturaAssetParamsResourceContainer = new KalturaAssetParamsResourceContainer();
						subResource.resource = subSubResource;
						subResource.assetParamsId = file.flavorParamsId;
						
						// add to list
						mediaResource.resources.push(subResource);
					}
					
				}
				
				// we saved this value in updateEntryContent() so we can use it here
				var mac:KalturaCall; 
				if (e.target.orphan) {
					mac = new MediaAddContent(entryid, mediaResource);
				} else {
					mac = new MediaUpdateContent(entryid, mediaResource);
				}
				mac.addEventListener(KalturaEvent.COMPLETE, startUploads);
				mac.addEventListener(KalturaEvent.FAILED, startUploads);
				_kc.post(mac);
			}
			else {
				// dispatch error event with relevant data
				var er:FileUploadEvent = new FileUploadEvent(FileUploadEvent.UPLOAD_ERROR, e.target.entryId);
				er.error = 'token creation failed for entry ' + e.target.entryId;
				dispatchEvent(er);
			}
		}
		
		
		/**
		 * handle errors if any, or start uploading files. 
		 * @param e
		 */
		protected function startUploads(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, startUploads);
			e.target.removeEventListener(KalturaEvent.FAILED, startUploads);
			if (e.type == KalturaEvent.COMPLETE) {
				// pass files to files list
				var entryid:String = e.data.id;
				var fuv:FileUploadVO;
				for (var i:int =_preprocessedFiles.length-1; i>=0; i--) {
					if ((_preprocessedFiles[i] as FileUploadVO).entryId == entryid) {
						_files.push(_preprocessedFiles[i]);
						_preprocessedFiles.splice(i, 1);
					}
				}
				dispatchEvent(new FileUploadEvent(FileUploadEvent.GROUP_UPLOAD_STARTED, entryid));
				// start uploading files
				if (_files.length < _concurrentUploads) {
					uploadNextFile();
				}
			}
			else {
				// dispatch error event with relevant data
				var er:FileUploadEvent = new FileUploadEvent(FileUploadEvent.UPLOAD_ERROR, '');
				er.error = 'adding content to entry failed';
				dispatchEvent(er);
			}
		}
		
		protected function getVoByFileName(name:String):FileUploadVO {
			var vo:FileUploadVO;
			for each (vo in _preprocessedFiles) {
				if (vo.file.name == name) {
					return vo;
				}
			}
			for each (vo in _files) {
				if (vo.file.name == name) {
					return vo;
				}
			}
			return null;
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
				var utu:UploadTokenUpload = new UploadTokenUpload(vo.uploadToken, vo.file);
				utu.queued = false;
				// add listeners with weak references because if upload fails, we can't clean them manually
				utu.addEventListener(KalturaEvent.COMPLETE, wrapUpUpload, false, 0, true);
				utu.addEventListener(KalturaEvent.FAILED, wrapUpUpload, false, 0, true);
				vo.file.addEventListener(IOErrorEvent.IO_ERROR, fileFailed );
				vo.file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, fileFailed);
				_kc.post(utu);
			}
		}
		
	
		/**
		 * dispatch complete event and remove the file from the list
		 */
		private function wrapUpUpload(e:KalturaEvent):void {
			e.target.removeEventListener(KalturaEvent.COMPLETE, wrapUpUpload);
			e.target.removeEventListener(KalturaEvent.FAILED, wrapUpUpload);
			var file:FileUploadVO = getUploadByUploadToken(e.data.id);
			if (e.type == KalturaEvent.COMPLETE) {
				file.status = FileUploadVO.STATUS_COMPLETE;
				// dispatch "fileUploadComplete" event with relevant unique identifier
				dispatchEvent(new FileUploadEvent(FileUploadEvent.UPLOAD_COMPLETE, file.id));
				//TODO dispatch end group event if needed
//				if (file.groupId) {
//					// add the file to a group_and_complete list
//					_groupAndComplete.push(file);
//					// if no other actions was specified, handle group issues
//					if (file.action == FileUploadVO.ACTION_NONE) {
//						handleGroupFile(file);
//					}
//				}
				// remove file from files list 
				var ind:int = getQueuePosition(file.id);
				_files.splice(ind, 1);
			}
			else {
				file.status = FileUploadVO.STATUS_FAILED;
				// dispatch error event with relevant data
				var er:FileUploadEvent = new FileUploadEvent(FileUploadEvent.UPLOAD_ERROR, e.target.entryId);
				er.error = e.error.errorMsg;
				dispatchEvent(er);
			}
			// start uploading the next file
			uploadNextFile();
		}
		
		

		
		/**
		 * update a single flavor asset, without creating replacement entry 
		 * @param file
		 */
		private function updateFlavorAsset(file:FileUploadVO):void {
//			// we don’t need flavorParamsId here
//			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset();
//			flavorAsset.setUpdatedFieldsOnly(true);
//			var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
//			// the token we used to upload the file
//			resource.token = file.uploadToken;	
//			var fau:FlavorAssetUpdate = new FlavorAssetUpdate(file.flavorAssetId, flavorAsset, resource);
//			fau.addEventListener(KalturaEvent.COMPLETE, flavorActionHandler);
//			fau.addEventListener(KalturaEvent.FAILED, flavorActionHandler);
//			_kc.post(fau);
		}

		
		/**
		 * add a single flavor asset to a no-media entry 
		 * @param file
		 */		
		private function addFlavorAsset(file:FileUploadVO):void {
//			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset();
//			// pass in the flavorParamsId of the flavor we want this to be;
//			flavorAsset.flavorParamsId = file.flavorParamsId;
//			flavorAsset.setUpdatedFieldsOnly(true);
//			flavorAsset.setInsertedFields(true);
//			var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
//			// the token we used to upload the file
//			resource.token = file.uploadToken;	
//			var faa:FlavorAssetAdd = new FlavorAssetAdd(file.entryId, flavorAsset, resource);
//			faa.addEventListener(KalturaEvent.COMPLETE, flavorActionHandler);
//			faa.addEventListener(KalturaEvent.FAILED, flavorActionHandler);
//			_kc.post(faa);
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
			// alert user 
			var er:FileUploadEvent = new FileUploadEvent(FileUploadEvent.UPLOAD_ERROR, e.target.entryId);
			er.error = ResourceManager.getInstance().getString('cms', 'uploadFailedMessage');
			dispatchEvent(er);
		}

		

		/**
		 * Cancels an upload according to uploadid.
		 *
		 * @param uploadid
		 */
//		public function cancelUpload(uploadid:String):void {
//			var file:FileUploadVO = getFile(uploadid);
//			if (!file) {
//				return;
//			}
//			//	call uploadToken.delete with relevant upload token.
//			var utd:UploadTokenDelete = new UploadTokenDelete(file.uploadToken);
//			utd.addEventListener(KalturaEvent.COMPLETE, handleDeleteResult);
//			utd.addEventListener(KalturaEvent.FAILED, handleDeleteResult);
//			_kc.post(utd);
//			// Dispatch "fileUploadCanceled" event.
//			dispatchEvent(new FileUploadEvent(FileUploadEvent.UPLOAD_CANCELED, uploadid));
//			// Remove relevant fileVo from files list.	
//			var ind:int = getQueuePosition(uploadid);
//			_files.splice(ind, 1);
//		}

		/**
		 * Retrieve a file vo according to its file reference object 
		 * @param id	file reference
		 * @return 		FileUploadVO 
		 */		
		protected function getUploadByFr(o:FileReference):FileUploadVO {
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
		protected function getUploadByUploadToken(id:String):FileUploadVO {
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