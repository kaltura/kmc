package com.kaltura.delegates.flavorParamsOutput
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class FlavorParamsOutputListDelegate extends WebDelegateBase
	{
		public function FlavorParamsOutputListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
