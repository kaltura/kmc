package com.kaltura.delegates.metadata
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class MetadataAddFromBulkDelegate extends WebDelegateBase
	{
		public function MetadataAddFromBulkDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
