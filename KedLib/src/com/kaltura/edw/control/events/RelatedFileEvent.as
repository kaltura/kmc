package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	public class RelatedFileEvent extends KMvCEvent
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