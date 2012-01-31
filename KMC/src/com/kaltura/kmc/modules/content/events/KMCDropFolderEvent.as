package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaDropFolder;
	
	public class KMCDropFolderEvent extends CairngormEvent {
		
		
		/**
		 * list all enabled drop folders, then list files for the folders in the list 
		 */
		public static const LIST_FOLDERS_AND_FILES:String = "df_list_folders_and_files";
		
		
		/**
		 * delete files from drop folder?
		 * event.data is array of fiels to delete
		 * */
		public static const DELETE_FILES:String = "delete_files";
		
		
		/**
		 * list all files from all drop folders
		 * */
		public static const LIST_ALL_FILES:String = "list_all";
		
		
		private var _folder:KalturaDropFolder;
		
		private var _flags:uint;
		
		
		public function KMCDropFolderEvent(type:String, folder:KalturaDropFolder = null, folderFlags:uint = 0x0, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_folder = folder;
			_flags = folderFlags;
		}

		public function get flags():uint
		{
			return _flags;
		}

		public function get folder():KalturaDropFolder
		{
			return _folder;
		}


	}
}