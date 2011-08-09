package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaDropFolder;
	
	import mx.controls.Alert;

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
		
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_LEAVE</code>, <code>ADD_NEW</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const MATCH_OR_NEW:uint = 0x0001;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_NEW</code>, <code>ADD_NEW</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const MATCH_OR_KEEP:uint = 0x0002;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag
		 *  with the <code>MATCH_OR_NEW</code>, <code>MATCH_OR_LEAVE</code>, <code>XML_FOLDER</code> flags.
		 */
		public static const ADD_NEW:uint = 0x0004;
		
		/**
		 *  Value that enables listing drop folder with this config when passed
		 *  as the <code>folderFlags</code> parameter of the constructor.
		 *  You can use the | operator to combine this bitflag with the 
		 *  <code>MATCH_OR_NEW</code>, <code>MATCH_OR_LEAVE</code>, <code>ADD_NEW</code> flags.
		 */
		public static const XML_FOLDER:uint = 0x0008;

		
		
		private var _folder:KalturaDropFolder;
		
		private var _flags:uint;
		

		public function DropFolderEvent(type:String, folder:KalturaDropFolder = null, folderFlags:uint = 0x0, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_folder = folder;
			_flags = folderFlags;
		}


		/**
		 * the drop folder this event referes to
		 */
		public function get folder():KalturaDropFolder {
			return _folder;
		}

		
		/**
		 * list flags 
		 * */
		public function get flags():uint {
			return _flags;
		}


	}
}