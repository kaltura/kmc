package com.kaltura.delegates.genericDistributionProvider
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class GenericDistributionProviderListDelegate extends WebDelegateBase
	{
		public function GenericDistributionProviderListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
