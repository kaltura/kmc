package com.kaltura.delegates.systemPartner
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class SystemPartnerGetConfigurationDelegate extends WebDelegateBase
	{
		public function SystemPartnerGetConfigurationDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
