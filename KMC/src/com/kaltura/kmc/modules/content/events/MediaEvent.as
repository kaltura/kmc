package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaMediaEntry;

	public class MediaEvent extends CairngormEvent
	{
		public static const ADD_ENTRY:String = "addEntry";
		public static const APPROVE_REPLACEMENT:String = "approveReplacement";
		public static const CANCEL_REPLACEMENT:String = "cancelReplacement";
		
		/**
		 * update media files on entry <br>
		 * data should be {conversionProfileId, resource}
		 */		
		public static const UPDATE_MEDIA:String = "updateMedia";
		
		
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