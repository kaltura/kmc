package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ConversionSettingsEvent extends CairngormEvent
	{
		public static const LIST_FLAVOR_PARAMS : String = "content_listFlavorParams";
		
		
		public function ConversionSettingsEvent(type:String, 
												data:Object=null,
										  		bubbles:Boolean=false, 
										  		cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}