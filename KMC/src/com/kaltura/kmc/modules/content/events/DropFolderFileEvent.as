package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaAssetsParamsResourceContainers;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaResource;

	public class DropFolderFileEvent extends CairngormEvent {

		/**
		 * reset the drop folder files list on the model
		 */		
		public static const RESET_FILES_LIST:String = "df_reset_files_list";
		
		/**
		 * list all files from all drop folders
		 * */
		public static const LIST_ALL:String = "list_all";
		
		/**
		 * list files in selected folder and create the array hierarchical
		 * */
		public static const LIST_BY_SELECTED_FOLDER_HIERCH:String = "df_list_by_selected_folder_hierch";
		
		/**
		 * list files in selected folder and create the array flat
		 */		
		public static const LIST_BY_SELECTED_FOLDER_FLAT:String = "df_list_by_selected_folder_flat";
		
		/**
		 * delete files from drop folder?
		 * */
		public static const DELETE_FILES:String = "delete_files";

		private var _entry:KalturaBaseEntry;
		private var _slug:String;
		private var _resources:KalturaResource;
		private var _selectedFiles:Array;


		public function DropFolderFileEvent(type:String, entry:KalturaBaseEntry=null, slug:String=null, resource:KalturaResource=null, selectedFiles:Array=null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_entry = entry;
			_slug = slug;
			_resources = resource;
			_selectedFiles = selectedFiles;
		}


		public function get entry():KalturaBaseEntry {
			return _entry;
		}


		public function get slug():String {
			return _slug;
		}


		public function get resource():KalturaResource {
			return _resources;
		}
		
		public function get selectedFiles():Array {
			return _selectedFiles;
		}

	}
}