package com.kaltura.delegates.media
{
	import com.kaltura.commands.media.MediaFlag;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class MediaFlagDelegate extends WebDelegateBase
	{
		public function MediaFlagDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
