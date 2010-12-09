package com.kaltura.delegates.flavorAsset
{
	import com.kaltura.commands.flavorAsset.FlavorAssetGet;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class FlavorAssetGetDelegate extends WebDelegateBase
	{
		public function FlavorAssetGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
