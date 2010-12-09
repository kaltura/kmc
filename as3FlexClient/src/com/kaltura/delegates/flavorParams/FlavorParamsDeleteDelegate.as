package com.kaltura.delegates.flavorParams
{
	import com.kaltura.commands.flavorParams.FlavorParamsDelete;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class FlavorParamsDeleteDelegate extends WebDelegateBase
	{
		public function FlavorParamsDeleteDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
