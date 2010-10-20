package com.kaltura.delegates.baseEntry
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class BaseEntryListFlagsDelegate extends WebDelegateBase
	{
		public function BaseEntryListFlagsDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
