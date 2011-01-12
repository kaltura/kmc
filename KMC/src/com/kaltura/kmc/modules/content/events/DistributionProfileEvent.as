package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DistributionProfileEvent extends CairngormEvent
	{
		public static const LIST:String = "content_listDistributionProfile";
		public static const UPDATE:String = "content_updateDistributionProfiles";
		
		public var distributionProfiles:Array;
		
		public function DistributionProfileEvent( type:String,
												  distributionProfiles:Array = null,
												  bubbles:Boolean=false, 
												  cancelable:Boolean=false)
		{
			this.distributionProfiles = distributionProfiles;
			super(type, bubbles, cancelable);
		}
	}
}