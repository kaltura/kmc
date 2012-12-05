package com.kaltura.kmc.modules.content.commands.dropfolder {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.KMCDropFolderEvent;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class ListDropFoldersFilesCommand extends KalturaCommand {
		// list_all / df_list_by_selected_folder_hierch / df_list_by_selected_folder_flat
		protected var _eventType:String;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var listEvent:KMCDropFolderEvent = event as KMCDropFolderEvent;
			_eventType = listEvent.type;
			var listFiles:DropFolderFileList;
			
			// drop folders panel
			listFiles = new DropFolderFileList(_model.dropFolderModel.filter, _model.dropFolderModel.pager);

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
				_model.dropFolderModel.files = new ArrayCollection(ar);
				_model.dropFolderModel.filesTotalCount = data.data.totalCount;
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
			ar = new Array();
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolderFile) {
					ar.push(o);
				}
			}
			return ar;
		}


	}
}