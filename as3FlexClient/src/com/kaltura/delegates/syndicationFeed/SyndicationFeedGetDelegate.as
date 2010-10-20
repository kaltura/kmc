package com.kaltura.delegates.syndicationFeed
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class SyndicationFeedGetDelegate extends WebDelegateBase
	{
		public function SyndicationFeedGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
