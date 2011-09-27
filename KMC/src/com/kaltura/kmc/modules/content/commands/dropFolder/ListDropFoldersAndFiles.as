package com.kaltura.kmc.modules.content.commands.dropFolder {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolder.DropFolderList;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.edw.control.events.DropFolderEvent;
	import com.kaltura.types.KalturaDropFolderContentFileHandlerMatchPolicy;
	import com.kaltura.types.KalturaDropFolderFileHandlerType;
	import com.kaltura.types.KalturaDropFolderFileOrderBy;
	import com.kaltura.types.KalturaDropFolderFileStatus;
	import com.kaltura.types.KalturaDropFolderOrderBy;
	import com.kaltura.types.KalturaDropFolderStatus;
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderContentFileHandlerConfig;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	import com.kaltura.vo.KalturaDropFolderFilter;
	import com.kaltura.vo.KalturaDropFolderListResponse;
	import com.kaltura.vo.KalturaFtpDropFolder;
	import com.kaltura.vo.KalturaScpDropFolder;
	import com.kaltura.vo.KalturaSftpDropFolder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.mx_internal;
	import mx.resources.ResourceManager;
	
//	use namespace mx.core.mx_internal;
	

	public class ListDropFoldersAndFiles extends KalturaCommand {

		
		private var _flags:uint;
		private var _fileFilter:KalturaDropFolderFileFilter;


		override public function execute(event:CairngormEvent):void {
			_flags = (event as DropFolderEvent).flags;
			_model.increaseLoadCounter();
			if (event.data is KalturaDropFolderFileFilter) {
				_fileFilter = event.data;
			}
			var filter:KalturaDropFolderFilter = new KalturaDropFolderFilter();
			filter.orderBy = KalturaDropFolderOrderBy.CREATED_AT_DESC;
			filter.statusEqual = KalturaDropFolderStatus.ENABLED;
			var listFolders:DropFolderList = new DropFolderList(filter);
			listFolders.addEventListener(KalturaEvent.COMPLETE, result);
			listFolders.addEventListener(KalturaEvent.FAILED, fault);

			_model.context.kc.post(listFolders);
		}


		override public function result(data:Object):void {
			if (data.error) {
				var er:KalturaError = data.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else {
				var ar:Array = handleDropFolderList(data.data as KalturaDropFolderListResponse);
				_model.dropFolderModel.dropFolders = new ArrayCollection(ar);
				
				if (ar.length == 0) {
					// show the annoying product-team alert
					var str:String = ResourceManager.getInstance().getString('cms', 'dfUpsale');
					var alert:Alert = Alert.show(str, ResourceManager.getInstance().getString('cms', 'attention'));
					alert.mx_internal::alertForm.mx_internal::textField.htmlText = str; // because it includes links and stuff
					_model.decreaseLoadCounter();
				}
				else {
					// load files from the returned folders
					if (!_fileFilter) {
						var folderIds:String = '';
						for each (var kdf:KalturaDropFolder in ar) {
							folderIds += kdf.id + ",";
						}
						_fileFilter = new KalturaDropFolderFileFilter();
						_fileFilter.orderBy = KalturaDropFolderFileOrderBy.CREATED_AT_DESC;
						// use selected folder
						_fileFilter.dropFolderIdIn = folderIds;
						_fileFilter.statusIn = KalturaDropFolderFileStatus.DOWNLOADING + "," +
							KalturaDropFolderFileStatus.ERROR_DELETING + "," + 
							KalturaDropFolderFileStatus.ERROR_DOWNLOADING + "," + 
							KalturaDropFolderFileStatus.ERROR_HANDLING + "," + 
							KalturaDropFolderFileStatus.HANDLED + "," + 
							KalturaDropFolderFileStatus.NO_MATCH + "," + 
							KalturaDropFolderFileStatus.PENDING + "," + 
							KalturaDropFolderFileStatus.UPLOADING + "," + 
							KalturaDropFolderFileStatus.WAITING; 
						_model.dropFolderModel.filter = _fileFilter;
					}
					var listFiles:DropFolderFileList = new DropFolderFileList(_fileFilter);
	
					listFiles.addEventListener(KalturaEvent.COMPLETE, filesResult);
					listFiles.addEventListener(KalturaEvent.FAILED, fault);
					_model.context.kc.post(listFiles);
				}
			}
//			_model.decreaseLoadCounter();
		}


		protected function filesResult(event:KalturaEvent):void {
			var ar:Array = new Array();
			var objs:Array = (event.data as KalturaDropFolderFileListResponse).objects;
			for each (var o:Object in objs) {
				if (o is KalturaDropFolderFile) {
					ar.push(o);
				}
			}
			_model.dropFolderModel.files = new ArrayCollection(ar);
			_model.dropFolderModel.filesTotalCount = event.data.totalCount;
			_model.decreaseLoadCounter();
		}


		/**
		 * put the folders in an array collection on the model
		 * */
		protected function handleDropFolderList(lr:KalturaDropFolderListResponse):Array {
			// so that the classes will be comiled in
			var dummy1:KalturaScpDropFolder;
			var dummy2:KalturaSftpDropFolder;
			var dummy3:KalturaFtpDropFolder;

			var df:KalturaDropFolder;
			var ar:Array = new Array();
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolder) {
					df = o as KalturaDropFolder;
					if (df.fileHandlerType == KalturaDropFolderFileHandlerType.CONTENT) {
						var cfg:KalturaDropFolderContentFileHandlerConfig = df.fileHandlerConfig as KalturaDropFolderContentFileHandlerConfig;
						if (_flags & DropFolderEvent.ADD_NEW && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.ADD_AS_NEW) {
							ar.push(df);
						}
						else if (_flags & DropFolderEvent.MATCH_OR_KEEP && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.MATCH_EXISTING_OR_KEEP_IN_FOLDER) {
							ar.push(df);
						}
						else if (_flags & DropFolderEvent.MATCH_OR_NEW && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.MATCH_EXISTING_OR_ADD_AS_NEW) {
							ar.push(df);
						}
					}
					else if (_flags & DropFolderEvent.XML_FOLDER && df.fileHandlerType == KalturaDropFolderFileHandlerType.XML) {
						ar.push(df);
					}
				}
			}
			return ar;
		}
	}
}