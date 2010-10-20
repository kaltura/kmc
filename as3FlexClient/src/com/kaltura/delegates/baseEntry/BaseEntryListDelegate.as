package com.kaltura.delegates.baseEntry
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class BaseEntryListDelegate extends WebDelegateBase
	{
		public function BaseEntryListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
