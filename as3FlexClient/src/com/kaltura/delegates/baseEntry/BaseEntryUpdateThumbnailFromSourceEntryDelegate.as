package com.kaltura.delegates.baseEntry
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class BaseEntryUpdateThumbnailFromSourceEntryDelegate extends WebDelegateBase
	{
		public function BaseEntryUpdateThumbnailFromSourceEntryDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
