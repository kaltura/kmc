package com.kaltura.delegates.flavorAsset
{
	import com.kaltura.commands.flavorAsset.FlavorAssetReconvert;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class FlavorAssetReconvertDelegate extends WebDelegateBase
	{
		public function FlavorAssetReconvertDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
