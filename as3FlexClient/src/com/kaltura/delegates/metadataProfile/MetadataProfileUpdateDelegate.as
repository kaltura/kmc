package com.kaltura.delegates.metadataProfile
{
	import com.kaltura.commands.metadataProfile.MetadataProfileUpdate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class MetadataProfileUpdateDelegate extends WebDelegateBase
	{
		public function MetadataProfileUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
