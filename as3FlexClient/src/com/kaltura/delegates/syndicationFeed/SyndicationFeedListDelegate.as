package com.kaltura.delegates.syndicationFeed
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class SyndicationFeedListDelegate extends WebDelegateBase
	{
		public function SyndicationFeedListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
