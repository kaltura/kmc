package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	
	import flash.net.FileReference;
	
	public class CaptionsEvent extends CairngormEvent
	{
		public static const LIST_CAPTIONS:String = "listCaptions";
		public static const UPLOAD_FILE:String = "uploadFile";
		public static const SAVE_ALL:String = "saveAll";
		
		
		public var caption:EntryCaptionVO;
		public var fr:FileReference;
		public var captionsToSave:Array;
		public var captionsToRemove:Array;
		public var defaultCaption:EntryCaptionVO
		
		public function CaptionsEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}