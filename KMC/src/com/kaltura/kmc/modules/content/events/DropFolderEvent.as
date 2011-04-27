package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaDropFolder;

	public class DropFolderEvent extends CairngormEvent {


		/**
		 * list drop folders that are configured for slug matching 
		 */
		public static const LIST_MATCH_FOLDERS:String = "df_list_match_folders";
		
		/**
		 * list all drop folders 
		 */
		public static const LIST_FOLDERS:String = "df_list_folders";
		
		/**
		 * set selected drop folder to the supplied drop folder 
		 */
		public static const SET_SELECTED_FOLDER:String = "df_set_selected_folder";

		
		
		private var _folder:KalturaDropFolder;
		

		public function DropFolderEvent(type:String, folder:KalturaDropFolder = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_folder = folder;
			
		}


		/**
		 * the drop folder this event referes to
		 */
		public function get folder():KalturaDropFolder {
			return _folder;
		}


	}
}