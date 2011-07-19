package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.RelatedFileVO;
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	public class RelatedFileEvent extends CairngormEvent
	{
		public static const LIST_RELATED_FILES:String = "listRelatedFiles";
		public static const SAVE_ALL_RELATED:String = "saveAllRelated";
		public static const UPDATE_RELATED_FILE:String = "updateRelatedFile";

		public var attachmentAsset:KalturaAttachmentAsset;
		/**
		 * array of related files to add 
		 */		
		public var relatedToAdd:Array;
		/**
		 * array of related files to update 
		 */		
		public var relatedToUpdate:Array;
		/**
		 * array of related files to delete 
		 */		
		public var relatedToDelete:Array;
		
		public function RelatedFileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}