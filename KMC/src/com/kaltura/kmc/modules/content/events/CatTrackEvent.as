package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CatTrackEvent extends CairngormEvent {
		
		/**
		 * get the current status from the server 
		 */		
		public static const UPDATE_STATUS:String = "cnt_updateCatStatus";
		
		
		public function CatTrackEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}