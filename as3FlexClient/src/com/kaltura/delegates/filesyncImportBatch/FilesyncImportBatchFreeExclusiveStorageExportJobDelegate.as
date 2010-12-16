package com.kaltura.delegates.filesyncImportBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class FilesyncImportBatchFreeExclusiveStorageExportJobDelegate extends WebDelegateBase
	{
		public function FilesyncImportBatchFreeExclusiveStorageExportJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
