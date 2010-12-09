package com.kaltura.delegates.flavorParams
{
	import com.kaltura.commands.flavorParams.FlavorParamsUpdate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class FlavorParamsUpdateDelegate extends WebDelegateBase
	{
		public function FlavorParamsUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
