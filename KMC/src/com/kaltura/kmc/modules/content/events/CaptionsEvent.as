package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CaptionsEvent extends CairngormEvent
	{
		public static const LIST_CAPTIONS:String = "listCaptions";
		
		
		public function CaptionsEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}