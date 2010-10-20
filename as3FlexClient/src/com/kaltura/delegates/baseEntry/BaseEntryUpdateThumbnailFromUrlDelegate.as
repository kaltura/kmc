package com.kaltura.delegates.baseEntry
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class BaseEntryUpdateThumbnailFromUrlDelegate extends WebDelegateBase
	{
		public function BaseEntryUpdateThumbnailFromUrlDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
