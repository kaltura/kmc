package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.ConversionProfileVO;

	public class ProfileEvent extends CairngormEvent
	{
		public static const ADD_CONVERSION_PROFILE : String = "content_addConversionProfile";
		public static const LIST_CONVERSION_PROFILE : String = "content_listConversionProfile";
		
		public function ProfileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}