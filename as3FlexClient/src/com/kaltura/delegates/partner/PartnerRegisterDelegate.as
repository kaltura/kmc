package com.kaltura.delegates.partner
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class PartnerRegisterDelegate extends WebDelegateBase
	{
		public function PartnerRegisterDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
