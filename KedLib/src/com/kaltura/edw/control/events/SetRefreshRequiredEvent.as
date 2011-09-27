package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SetRefreshRequiredEvent extends CairngormEvent
	{
		public static const SET_REFRESH_REQUIRED : String = "setRefreshRequired";
		
		public var value:Boolean;
		
		public function SetRefreshRequiredEvent(type:String , value:Boolean , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.value = value;
			super(type, bubbles, cancelable);
		}
	}
}