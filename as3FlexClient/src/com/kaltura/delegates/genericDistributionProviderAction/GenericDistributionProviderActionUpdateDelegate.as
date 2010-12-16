package com.kaltura.delegates.genericDistributionProviderAction
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class GenericDistributionProviderActionUpdateDelegate extends WebDelegateBase
	{
		public function GenericDistributionProviderActionUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
