package com.kaltura.delegates.thumbAsset
{
	import com.kaltura.commands.thumbAsset.ThumbAssetRegenerate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class ThumbAssetRegenerateDelegate extends WebDelegateBase
	{
		public function ThumbAssetRegenerateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

		override public function parse( result : XML ) : *
		{
			return result.result.toString();
		}

	}
}
