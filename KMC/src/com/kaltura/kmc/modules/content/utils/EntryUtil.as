package com.kaltura.kmc.modules.content.utils
{
	import com.kaltura.managers.FileUploadManager;
	import com.kaltura.vo.FileUploadVO;

	/**
	 * This class will hold functions related to kaltura entries 
	 * @author Michal
	 * 
	 */	
	public class EntryUtil
	{
		
		/**
		 * checks if any files related to an entry are currently uploading via upload manager
		 * @param entryid	id of the entry in question
		 * @return true if files are handled by upload manager, false otherwise.
		 * */
		public static function isRelatedFileUploading(entryid:String):Boolean {
			var uploadingfiles:Vector.<FileUploadVO> = FileUploadManager.getInstance().getAllFiles();
			var result:Boolean;
			for each (var file:FileUploadVO in uploadingfiles) {
				if (file.entryId == entryid) {
					result = true;
					break;
				}
			}
			return result;
		}
	}
}