package com.kaltura.delegates.accessControl
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class AccessControlUpdateDelegate extends WebDelegateBase
	{
		public function AccessControlUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
