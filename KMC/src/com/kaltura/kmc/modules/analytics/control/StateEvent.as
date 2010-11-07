package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class StateEvent extends CairngormEvent
	{
		public static const STATE_CHANGE : String = "analytics_stateChange";
		
		public var newState : int;
		
		public function StateEvent(type:String, newState : int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.newState = newState;
		}	
	}
}