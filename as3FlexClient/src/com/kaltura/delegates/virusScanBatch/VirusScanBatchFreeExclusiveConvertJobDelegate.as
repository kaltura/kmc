package com.kaltura.delegates.virusScanBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class VirusScanBatchFreeExclusiveConvertJobDelegate extends WebDelegateBase
	{
		public function VirusScanBatchFreeExclusiveConvertJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
