package com.kaltura.delegates.baseEntry
{
	import com.kaltura.commands.baseEntry.BaseEntryUpdateThumbnailFromUrl;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class BaseEntryUpdateThumbnailFromUrlDelegate extends WebDelegateBase
	{
		public function BaseEntryUpdateThumbnailFromUrlDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
