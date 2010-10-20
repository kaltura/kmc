package com.kaltura.delegates.session
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class SessionStartWidgetSessionDelegate extends WebDelegateBase
	{
		public function SessionStartWidgetSessionDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
