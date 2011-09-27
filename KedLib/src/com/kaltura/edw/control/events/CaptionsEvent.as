package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.view.captions.Caption;
	import com.kaltura.edw.vo.EntryCaptionVO;
	
	import flash.net.FileReference;
	
	public class CaptionsEvent extends CairngormEvent
	{
		public static const LIST_CAPTIONS:String = "listCaptions";
		public static const SAVE_ALL:String = "saveAllCaptions";
		
		/**
		 * get the captionAsset, if its status=ready ask for the updated donwload URL
		 * */
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