package com.kaltura.delegates.thumbAsset
{
	import com.kaltura.commands.thumbAsset.ThumbAssetGenerateByEntryId;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class ThumbAssetGenerateByEntryIdDelegate extends WebDelegateBase
	{
		public function ThumbAssetGenerateByEntryIdDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

		override public function parse( result : XML ) : *
		{
			return result.result.toString();
		}

	}
}
