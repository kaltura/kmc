package com.kaltura.delegates.metadata
{
	import com.kaltura.commands.metadata.MetadataAdd;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class MetadataAddDelegate extends WebDelegateBase
	{
		public function MetadataAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
