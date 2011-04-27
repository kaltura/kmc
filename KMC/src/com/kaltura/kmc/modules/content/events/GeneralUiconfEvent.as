package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GeneralUiconfEvent extends CairngormEvent
	{
		public static const GET_METADATA_UICONF:String = "get_metadata_uiconf";
		
		public function GeneralUiconfEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}