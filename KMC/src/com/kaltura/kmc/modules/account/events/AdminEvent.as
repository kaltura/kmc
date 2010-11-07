package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class AdminEvent extends CairngormEvent
	{
		public static const UPDATE_ADMIN_PASSWORD : String = "account_updateAdminPassword";
		public function AdminEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}