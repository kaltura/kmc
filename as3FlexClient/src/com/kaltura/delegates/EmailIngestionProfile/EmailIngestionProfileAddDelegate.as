package com.kaltura.delegates.EmailIngestionProfile
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class EmailIngestionProfileAddDelegate extends WebDelegateBase
	{
		public function EmailIngestionProfileAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
