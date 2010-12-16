package com.kaltura.delegates.contentDistributionBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class ContentDistributionBatchUpdateExclusiveProvisionProvideJobDelegate extends WebDelegateBase
	{
		public function ContentDistributionBatchUpdateExclusiveProvisionProvideJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
