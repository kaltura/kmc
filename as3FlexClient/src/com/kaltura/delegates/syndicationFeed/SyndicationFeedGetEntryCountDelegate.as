package com.kaltura.delegates.syndicationFeed
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class SyndicationFeedGetEntryCountDelegate extends WebDelegateBase
	{
		public function SyndicationFeedGetEntryCountDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
