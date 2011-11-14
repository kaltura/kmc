package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;

	public class DistributionProfileEvent extends KMvCEvent
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