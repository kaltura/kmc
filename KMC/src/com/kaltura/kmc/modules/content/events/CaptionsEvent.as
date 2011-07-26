package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.captionsComponents.Caption;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	
	import flash.net.FileReference;
	
	public class CaptionsEvent extends CairngormEvent
	{
		public static const LIST_CAPTIONS:String = "listCaptions";
		public static const SAVE_ALL:String = "saveAll";
		public static const UPDATE_CAPTION:String = "updateCaption";
		
		
		public var captionsToSave:Array;
		public var captionsToRemove:Array;
		public var defaultCaption:EntryCaptionVO;
		
		public var captionVo:EntryCaptionVO;
		
		public function CaptionsEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}