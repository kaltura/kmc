package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DistributionProfileEvent extends CairngormEvent
	{
		public static const LIST:String = "content_listDistributionProfile";
		
		public function DistributionProfileEvent( type:String,
												  bubbles:Boolean=false, 
												  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}