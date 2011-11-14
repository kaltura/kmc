package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class AccessControlEvent extends KMvCEvent {
		
		public static const LIST_ACCESS_CONTROLS_PROFILES:String = "listAllAccessControlProfiles";
		
		public static const ADD_NEW_ACCESS_CONTROL_PROFILE:String = "addNewAccessControlProfile";
		
		public static const UPDATE_ACCESS_CONTROL_PROFILE:String = "updateAccessControlProfile";
		
		public function AccessControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}