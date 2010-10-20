package com.kaltura.delegates.media
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class MediaAddFromUrlDelegate extends WebDelegateBase
	{
		public function MediaAddFromUrlDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
