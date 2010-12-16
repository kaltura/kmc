package com.kaltura.delegates.contentDistributionBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class ContentDistributionBatchUpdateExclusiveMailJobDelegate extends WebDelegateBase
	{
		public function ContentDistributionBatchUpdateExclusiveMailJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
