package com.kaltura.delegates.filesyncImportBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class FilesyncImportBatchUpdateExclusiveProvisionProvideJobDelegate extends WebDelegateBase
	{
		public function FilesyncImportBatchUpdateExclusiveProvisionProvideJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
