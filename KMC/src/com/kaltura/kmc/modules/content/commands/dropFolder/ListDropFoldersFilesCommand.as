package com.kaltura.kmc.modules.content.commands.dropFolder {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.types.KalturaDropFolderFileOrderBy;
	import com.kaltura.types.KalturaDropFolderFileStatus;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileFilter;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class ListDropFoldersFilesCommand extends KalturaCommand {
		// list_all / df_list_by_selected_folder_hierch / df_list_by_selected_folder_flat
		protected var _eventType:String;

		protected var _entry:KalturaBaseEntry;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var listEvent:DropFolderFileEvent = event as DropFolderFileEvent;
			_eventType = listEvent.type;
			_entry = listEvent.entry;
			var listFiles:DropFolderFileList;
			
			// drop folders panel
			if (_eventType == DropFolderFileEvent.LIST_ALL) {
				listFiles = new DropFolderFileList(_model.dropFolderModel.filter, _model.dropFolderModel.pager);
			}
			// match from drop folder popup
			else {
				var filter:KalturaDropFolderFileFilter = new KalturaDropFolderFileFilter();
				filter.orderBy = KalturaDropFolderFileOrderBy.CREATED_AT_DESC;
				// use selected folder
				filter.dropFolderIdEqual = _model.dropFolderModel.selectedDropFolder.id;
				// if searching for slug
				if (listEvent.slug) {
					filter.parsedSlugLike = listEvent.slug;
				}
				// file status
				filter.statusIn = KalturaDropFolderFileStatus.NO_MATCH + "," + KalturaDropFolderFileStatus.WAITING + "," + KalturaDropFolderFileStatus.ERROR_HANDLING;
				listFiles = new DropFolderFileList(filter);
			}

			listFiles.addEventListener(KalturaEvent.COMPLETE, result);
			listFiles.addEventListener(KalturaEvent.FAILED, fault);

			_model.context.kc.post(listFiles);
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
		 * list hierarchical:
		 * 	group items by slug
		 *
		 * list all or list flat:
		 *  just push the items to the model
		 *  */
		protected function handleDropFolderFileList(lr:KalturaDropFolderFileListResponse):Array {
			var ar:Array; // results array
			if (_eventType == DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH) {
				ar = createHierarchicData(lr);
			}
			else if (_eventType == DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_FLAT) {
				ar = createFlatData(lr);
			}
			else {
				ar = new Array();
				for each (var o:Object in lr.objects) {
					if (o is KalturaDropFolderFile) {
						ar.push(o);
					}
				}
			}
			return ar;
		}


		protected function createFlatData(lr:KalturaDropFolderFileListResponse):Array {
			var dff:KalturaDropFolderFile;
			var ar:Array = new Array(); // results array
			var arWait:Array = new Array(); // waiting array

			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolderFile) {
					dff = o as KalturaDropFolderFile;
					// for files in status waiting, we only want files with a matching slug
					if (dff.status == KalturaDropFolderFileStatus.WAITING) {
						if (dff.parsedSlug != _entry.referenceId) {
							continue;
						}
						else {
							arWait.push(dff)
						}
					}
					// .. and all other fiels
					else {
						ar.push(dff);
					}
				}
			}

			// put the matched waiting files first
			while (arWait.length > 0) {
				ar.unshift(arWait.pop());
			}
			return ar;
		}


		/**
		 * Slug Based Folders:
		 * 	create a new dropfolderfile for each slug
		 * 	pouplate its createdAt property according to the file that created it.
		 * 	for each file:
		 * 	- if no matching slug object is found, create matching slug object.
		 * 	- update date on slug if needed
		 * 	- push the dff to the "files" attribute on the slug vo
		 */
		protected function createHierarchicData(lr:KalturaDropFolderFileListResponse):Array {
			var dff:KalturaDropFolderFile;
			var ar:Array = new Array(); // results array
			var dict:Object = new Object(); // slugs dictionary
			var group:KalturaDropFolderFile; // dffs group (by slug)

			var parseFailedStr:String = ResourceManager.getInstance().getString('cms', 'parseFailed');
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolderFile) {
					dff = o as KalturaDropFolderFile;
					// for files in status waiting, we only want files with a matching slug
					if (dff.status == KalturaDropFolderFileStatus.WAITING) {
						if (dff.parsedSlug != _entry.referenceId) {
							continue;
						}
					}
					// group all files where status == ERROR_HANDLING under same group
					if (dff.status == KalturaDropFolderFileStatus.ERROR_HANDLING) {
						dff.parsedSlug = parseFailedStr;
					}
					// get relevant group
					if (!dict[dff.parsedSlug]) {
						// create group
						group = new KalturaDropFolderFile();
						group.parsedSlug = dff.parsedSlug;
						group.createdAt = dff.createdAt;
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
					// if any file in the group is in waiting status, set the group to waiting:
					if (dff.status == KalturaDropFolderFileStatus.WAITING) {
						group.status = KalturaDropFolderFileStatus.WAITING;
					}
				}
			}
			var wait:KalturaDropFolderFile;
			for (var slug:String in dict) {
				if (slug != parseFailedStr) {
					if (dict[slug].status == KalturaDropFolderFileStatus.WAITING) {
						// we assume there's only one...
						wait = dict[slug] as KalturaDropFolderFile;
					}
					else {
						ar.push(dict[slug]);
					}
				}
			}
			// put the matched waiting file first
			if (wait) {
				ar.unshift(wait);
			}
			// put the parseFailed last
			if (dict[parseFailedStr]) {
				ar.push(dict[parseFailedStr]);
			}
			return ar;
		}
	}
}