package com.kaltura.delegates.thumbAsset
{
	import com.kaltura.commands.thumbAsset.ThumbAssetAddFromUrl;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class ThumbAssetAddFromUrlDelegate extends WebDelegateBase
	{
		public function ThumbAssetAddFromUrlDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
