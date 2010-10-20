package com.kaltura.events
{
	import flash.events.Event;

	public class WrapperEvent extends Event
	{
		public static const SECURITY_PERMISSIONS_ALLOWED:String = "securityPermissionsAllowed";
		
		public function WrapperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}