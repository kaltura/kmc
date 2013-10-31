package com.kaltura.kmc.modules.account.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaUserFilter;
	
	public class UserEvent extends CairngormEvent {
		
		public static const LIST_USERS:String = "account_listUsers";
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

	}
}