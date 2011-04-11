package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaDropFolder;

	public class DropFolderEvent extends CairngormEvent {


		public static const LIST_CONTENT:String = "df_list_content";
		public static const LIST_FOLDERS:String = "df_list_folders";
		public static const SET_SELECTED_FOLDER:String = "df_set_selected_folder";

		private var _folder:KalturaDropFolder;
		private var _slug:String;
		


		public function DropFolderEvent(type:String, slug:String='', folder:KalturaDropFolder = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_slug = slug;
			_folder = folder;
			
		}


		/**
		 * the drop folder this event referes to
		 */
		public function get folder():KalturaDropFolder {
			return _folder;
		}

		/**
		 * slug to use in search
		 * */
		public function get slug():String
		{
			return _slug;
		}


	}
}