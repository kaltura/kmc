package com.kaltura.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class AccessControlProfileEvent extends CairngormEvent
	{
		public static const LIST_ACCESS_CONTROLS_PROFILES : String = "listAllAccessControlProfiles";
		public static const DELETE_ACCESS_CONTROL_PROFILES : String = "deleteAccessControlProfiles";
		public static const ADD_NEW_ACCESS_CONTROL_PROFILE : String = "addNewAccessControlProfile";
		public static const UPDATE_ACCESS_CONTROL_PROFILE : String = "updateAccessControlProfile";
		public static const MARK_PROFILES : String = "markProfiles";
		
		public var selected : Boolean;
		
		public function AccessControlProfileEvent(type:String, 
												  selected:Boolean=false , 
												  bubbles:Boolean=false, 
												  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.selected = selected;
			this.data = data;
		}
	}
}