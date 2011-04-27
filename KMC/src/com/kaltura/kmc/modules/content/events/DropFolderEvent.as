package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaDropFolder;

	public class DropFolderEvent extends CairngormEvent {


		public static const LIST_CONTENT:String = "df_list_content";
		public static const LIST_FOLDERS:String = "df_list_folders";
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