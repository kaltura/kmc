package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaMediaEntry;

	public class MediaEvent extends CairngormEvent
	{
		public static const ADD_MEDIA:String = "addMedia";
		public static const APPROVE_REPLACEMENT:String = "approveReplacement";
		public static const CANCEL_REPLACEMENT:String = "cancelReplacement";
		
		public var entry:KalturaMediaEntry;
		/**
		 * whether to open entrydrilldown after response returns
		 * */
		public var openDrilldown:Boolean;
		
		public function MediaEvent(type:String, entry:KalturaMediaEntry, openDrilldown:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.entry = entry;
			this.openDrilldown = openDrilldown;
			super(type, bubbles, cancelable);
		}
	}
}