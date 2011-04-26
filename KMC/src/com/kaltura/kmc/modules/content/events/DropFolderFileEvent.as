package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaAssetsParamsResourceContainers;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaResource;

	public class DropFolderFileEvent extends CairngormEvent {

		/**
		 * set media to entry according to slug / file 
		 */		
		public static const MATCH_MEDIA:String = "df_match_media";
		
		/**
		 * replace a single flavor on an entry with a drop folder file.
		 * */
		public static const UPDATE_SINGLE_FLAVOR:String = "df_update_single_flavor";
		
		/**
		 * add a drop folder file as a single flavor to an entry.
		 * */
		public static const ADD_SINGLE_FLAVOR:String = "df_add_single_flavor";
		
		/**
		 * list all files from all drop folders
		 * */
		public static const LIST_ALL:String = "list_all";
		
		/**
		 * list files in selected folder and create the array hierarchical or not, based on folder config
		 * */
		public static const LIST_BY_SELECTED_FOLDER_AUTO:String = "df_list_by_selected_folder_auto";
		
		/**
		 * list files in selected folder and create the array flat, regardless of folder config
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