package com.kaltura.delegates.thumbAsset
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class ThumbAssetSetAsDefaultDelegate extends WebDelegateBase
	{
		public function ThumbAssetSetAsDefaultDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
