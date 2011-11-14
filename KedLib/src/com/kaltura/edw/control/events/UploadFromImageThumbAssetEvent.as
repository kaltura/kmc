package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import flash.net.FileReference;

	public class UploadFromImageThumbAssetEvent extends KMvCEvent
	{
		public static const ADD_FROM_IMAGE:String = "content_addFromImage";
		public var entryId:String;
		public var thumbnailFileReference:FileReference;
		
		public function UploadFromImageThumbAssetEvent(type:String, entry_id:String, file_reference:FileReference, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			entryId = entry_id;
			thumbnailFileReference = file_reference;
			super(type, bubbles, cancelable);
		}
	}
}