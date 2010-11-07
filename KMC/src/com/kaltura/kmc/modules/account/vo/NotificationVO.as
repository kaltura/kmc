package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class NotificationVO implements IValueObject
	{
		public var nId : String = "";
		public var name : String = "";
		
		/**
		 * this notification is available for client 
		 */		
		public var availableInClient : Boolean = false;
		
		/**
		 * this notification is available for server 
		 */		
		public var availableInServer : Boolean = false;
		
		public var clientEnabled : Boolean = false;
	}
}