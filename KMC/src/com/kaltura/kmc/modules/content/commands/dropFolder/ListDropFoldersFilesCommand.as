package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.types.KalturaDropFolderContentFileHandlerMatchPolicy;
	import com.kaltura.types.KalturaDropFolderFileHandlerType;
	import com.kaltura.types.KalturaDropFolderFileStatus;
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderContentFileHandlerConfig;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class ListDropFoldersFilesCommand extends KalturaCommand
	{
		//list_all or list_by_selected_folder
		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void {
			_eventType = (event as DropFolderFileEvent).type;
			createHandleDummy();
			/*_model.increaseLoadCounter();
			var listEvent:DropFolderFileEvent = event as DropFolderFileEvent;
			
			var filter:KalturaDropFolderFileFilter;
			if (listEvent.type == DropFolderFileEvent.LIST_ALL) {
				filter = _model.dropFolderModel.filter;
			}
			else {
				filter = new KalturaDropFolderFileFilter();
				// use selected folder
				filter.dropFolderIdEqual = _model.dropFolderModel.selectedDropFolder.id;
				// if searching for slug
				if (listEvent.slug) 
					filter.parsedSlugLike = listEvent.slug;
			}
			
			var listFiles:DropFolderFileList = new DropFolderFileList(filter);
			listFiles.addEventListener(KalturaEvent.COMPLETE, result);
			listFiles.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listFiles); */
		}

		override public function result(data:Object):void {
			if (data.error) {
				var er:KalturaError = data.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else {
				var ar:Array = handleDropFolderFileList(data.data as KalturaDropFolderFileListResponse);
				if (_eventType == DropFolderFileEvent.LIST_ALL) {
					_model.dropFolderModel.files = new ArrayCollection(ar);
					_model.dropFolderModel.filesTotalCount = data.data.totalCount;
				}
				else {
					_model.dropFolderModel.dropFolderFiles = new ArrayCollection(ar);
				}
			}
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * slug based folders:
		 * 	group items by slug
		 * 
		 * regular folders:
		 *  just push the items to the model
		 *  */
		protected function handleDropFolderFileList(lr:KalturaDropFolderFileListResponse):Array {
			var df:KalturaDropFolder = _model.dropFolderModel.selectedDropFolder;
			var dff:KalturaDropFolderFile;
			var ar:Array = new Array();	// results array
			var isSlug:Boolean = df != null;
			isSlug &&= df.fileHandlerConfig.handlerType == KalturaDropFolderFileHandlerType.CONTENT;
			isSlug &&= (df.fileHandlerConfig as KalturaDropFolderContentFileHandlerConfig).contentMatchPolicy != KalturaDropFolderContentFileHandlerMatchPolicy.ADD_AS_NEW;   
			
			if (isSlug && _eventType == DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_AUTO) {
				/* 
				* Slug Based Folders:
				* 	create a new dropfolderfile for each slug
				* 	pouplate its createdAt property according to the file that created it.
				* 	for each file:
				* 	- if no matching slug object is found, create matching slug object.
				* 	- update date on slug if needed
				* 	- push the dff to the "files" attribute on the slug vo
				*/
				var dict:Object = new Object();		// slugs dictionary
				var group:KalturaDropFolderFile;	// dffs group (by slug)
				for each (var o:Object in lr.objects) {
					if (o is KalturaDropFolderFile) {
						dff = o as KalturaDropFolderFile;
						if (!dict[dff.parsedSlug]) {
							// create group
							group = new KalturaDropFolderFile();
							group.parsedSlug = dff.parsedSlug;
							group.creaedAt = dff.createdAt;
							group.files = new Array();
							dict[group.parsedSlug] = group;
						}
						else {
							group = dict[dff.parsedSlug];
							// update date if needed
							if (group.createdAt > dff.createdAt) {
								group.createdAt = dff.createdAt;
							}
						}
						// add dff to files list
						group.files.push(dff);
					}
				}
				for (var slug:String in dict) {
					ar.push(dict[slug]);
				}
			}
			else {
				// regular folders: just push the items to the model
				for each (var oo:Object in lr.objects) {
					if (oo is KalturaDropFolderFile) {
						ar.push(oo);
					}
				}
			}
			return ar;
		//	_model.dropFolderModel.dropFolderFiles = new ArrayCollection(ar);
		}
		
		protected function createHandleDummy() :void {
			var response:KalturaDropFolderFileListResponse = new KalturaDropFolderFileListResponse();
			response.objects = new Array();
			var dff:KalturaDropFolderFile = new KalturaDropFolderFile();
			dff.createdAt = 105348965;
			dff.dropFolderId = 6;
			dff.fileName = "file_1";
			dff.fileSize = 3145728.1111111111111111111111111;
			dff.status = KalturaDropFolderFileStatus.PENDING;
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 115348665;
			dff.dropFolderId = 6;
			dff.fileName = "file_2";
			dff.fileSize = 3145728*2;
			dff.status = KalturaDropFolderFileStatus.UPLOADING;
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 125348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_3";
			dff.fileSize = 3145728*6;
			dff.status = KalturaDropFolderFileStatus.ERROR_DELETING;
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 135348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_4";
			dff.fileSize = 3145728/4;
			dff.status = KalturaDropFolderFileStatus.ERROR_HANDLING;
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);

			
			var resultArray:Array = handleDropFolderFileList(response);
			if (_eventType == DropFolderFileEvent.LIST_ALL) {
				_model.dropFolderModel.files = new ArrayCollection(resultArray);
				//_model.dropFolderModel.filesTotalCount = response.totalCount;
				_model.dropFolderModel.filesTotalCount = 30;
			}
			else
				_model.dropFolderModel.dropFolderFiles = new ArrayCollection(resultArray);
		}

	}
		
}