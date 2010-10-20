package com.kaltura.delegates.EmailIngestionProfile
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class EmailIngestionProfileUpdateDelegate extends WebDelegateBase
	{
		public function EmailIngestionProfileUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
