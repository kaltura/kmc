package com.kaltura.delegates.genericDistributionProviderAction
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class GenericDistributionProviderActionAddDelegate extends WebDelegateBase
	{
		public function GenericDistributionProviderActionAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
