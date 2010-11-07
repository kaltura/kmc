package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class KalturaEvent extends CairngormEvent
	{
		public static const CONTACT_US : String = "account_contactUs";
		public var userName : String = "";
		public var userPhone : String = "";
		public var userComment : String = "";
		public var services : String = "";
		
		public function KalturaEvent( type:String,
									  userName:String,
									  userPhone:String,
									  userComment:String,
									  services : String,
									  bubbles:Boolean=false, 
									  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.userName = userName;
			this.userPhone = userPhone;
			this.userComment = userComment;
			this. services = services;
		}
	}
}