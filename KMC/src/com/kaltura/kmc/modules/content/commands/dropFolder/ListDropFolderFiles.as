package com.kaltura.kmc.modules.content.commands.dropFolder {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.DropFolderEvent;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;

	public class ListDropFolderFiles extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			createHandleDummy();
			// ---------------------
			/*_model.increaseLoadCounter();
			var filter:KalturaDropFolderFileFilter = new KalturaDropFolderFileFilter();
			// use selected folder
			filter.dropFolderIdEqual = _model.dropFolderModel.selectedDropFolder.id;
			// if searching for slug
			if ((event as DropFolderEvent).slug) {
				filter.parsedSlugLike = (event as DropFolderEvent).slug;
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
				handleDropFolderFileList(data.data as KalturaDropFolderFileListResponse);
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
		protected function handleDropFolderFileList(lr:KalturaDropFolderFileListResponse):void {
			var dff:KalturaDropFolderFile;
			var ar:Array = new Array();				// results array
			if (_model.dropFolderModel.selectedDropFolder.slugField != null) {
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
			_model.dropFolderModel.dropFolderFiles = new ArrayCollection(ar);
		}

		protected function createHandleDummy() :void {
			var response:KalturaDropFolderFileListResponse = new KalturaDropFolderFileListResponse();
			response.objects = new Array();
			var dff:KalturaDropFolderFile = new KalturaDropFolderFile();
			dff.createdAt = 105348965;
			dff.dropFolderId = 6;
			dff.fileName = "file_1";
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 115348665;
			dff.dropFolderId = 6;
			dff.fileName = "file_2";
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 125348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_3";
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 135348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_4";
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);
			
			handleDropFolderFileList(response);
		}

	}
}