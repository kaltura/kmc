package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class NotificationVO implements IValueObject
	{
		public var nId : String = "";
		public var name : String = "";
		public var availableInClient : Boolean = false;
		public var availableInServer : Boolean = false;
		public var clientEnabled : Boolean = false;
	}
}