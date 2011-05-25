package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class AccessControlEvent extends CairngormEvent {
		
		public static const ACCOUNT_LIST_ACCESS_CONTROLS_PROFILES : String = "accountListAllAccessControlProfiles";
		public static const ACCOUNT_DELETE_ACCESS_CONTROL_PROFILES : String = "accountDeleteAccessControlProfiles";
		public static const ACCOUNT_ADD_NEW_ACCESS_CONTROL_PROFILE : String = "accountAddNewAccessControlProfile";
		public static const ACCOUNT_UPDATE_ACCESS_CONTROL_PROFILE : String = "accountUpdateAccessControlProfile";
		public static const ACCOUNT_MARK_PROFILES : String = "accountMarkProfiles";
		
		public var selected : Boolean;
		
		public function AccessControlEvent(type:String, 
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