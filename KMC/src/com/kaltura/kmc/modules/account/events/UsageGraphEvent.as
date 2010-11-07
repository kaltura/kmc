package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class  UsageGraphEvent extends CairngormEvent
	{
		public static const USAGE_GRAPH : String = "usageGraph";
		
		public function UsageGraphEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}