package com.kaltura.delegates.entryDistribution
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class EntryDistributionDeleteDelegate extends WebDelegateBase
	{
		public function EntryDistributionDeleteDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
