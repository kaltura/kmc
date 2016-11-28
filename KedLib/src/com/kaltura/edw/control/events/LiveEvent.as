package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;

	public class LiveEvent extends KMvCEvent
	{
		/**
		 * regenerate live stream security token
		 */
		public static const REGENERATE_LIVE_TOKEN : String = "content_regenerateLiveToken";
		
		
		public function LiveEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}