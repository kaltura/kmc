package com.kaltura.delegates.notification
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class NotificationGetClientNotificationDelegate extends WebDelegateBase
	{
		public function NotificationGetClientNotificationDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
