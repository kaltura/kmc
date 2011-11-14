package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CustomDataEvent extends CairngormEvent
	{
		public static const GET_METADATA_UICONF:String = "get_metadata_uiconf";
		
		public static const LIST_PROFILES:String = "content_listMetadataProfile";
		
		public function CustomDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}