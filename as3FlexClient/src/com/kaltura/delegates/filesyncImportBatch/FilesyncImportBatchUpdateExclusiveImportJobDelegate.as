package com.kaltura.delegates.filesyncImportBatch
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class FilesyncImportBatchUpdateExclusiveImportJobDelegate extends WebDelegateBase
	{
		public function FilesyncImportBatchUpdateExclusiveImportJobDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
