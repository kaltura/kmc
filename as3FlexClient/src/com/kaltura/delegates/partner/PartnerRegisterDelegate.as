package com.kaltura.delegates.partner
{
	import com.kaltura.commands.partner.PartnerRegister;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class PartnerRegisterDelegate extends WebDelegateBase
	{
		public function PartnerRegisterDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
