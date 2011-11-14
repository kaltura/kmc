package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import flash.net.FileReference;
	

	public class UploadEntryEvent extends KMvCEvent
	{
		public static const UPLOAD_THUMBNAIL : String = "content_uploadThumbnail";
		
		public var fileReferance:FileReference;
		public var entryId:String;
		
		public function UploadEntryEvent(type:String,entryId:String , fileReferance : FileReference , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.fileReferance = fileReferance;
			this.entryId = entryId;
		}
	}
}