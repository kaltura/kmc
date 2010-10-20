package com.kaltura.delegates.liveStream
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class LiveStreamUpdateOfflineThumbnailFromUrlDelegate extends WebDelegateBase
	{
		public function LiveStreamUpdateOfflineThumbnailFromUrlDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
