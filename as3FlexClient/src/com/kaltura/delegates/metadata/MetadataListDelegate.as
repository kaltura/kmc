package com.kaltura.delegates.metadata
{
	import com.kaltura.commands.metadata.MetadataList;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class MetadataListDelegate extends WebDelegateBase
	{
		public function MetadataListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
