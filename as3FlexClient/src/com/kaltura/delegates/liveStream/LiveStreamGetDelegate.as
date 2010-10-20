package com.kaltura.delegates.liveStream
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class LiveStreamGetDelegate extends WebDelegateBase
	{
		public function LiveStreamGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
