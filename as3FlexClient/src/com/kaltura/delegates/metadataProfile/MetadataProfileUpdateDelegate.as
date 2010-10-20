package com.kaltura.delegates.metadataProfile
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class MetadataProfileUpdateDelegate extends WebDelegateBase
	{
		public function MetadataProfileUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
