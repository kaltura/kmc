package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class PermissionEvent extends CairngormEvent {
		
		/**
		 * remove a report.
		 * event.data should be the string to be removed from the DTN
		 */
		public static const REMOVE_REPORT:String = "remove_report";
		
		public function PermissionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}