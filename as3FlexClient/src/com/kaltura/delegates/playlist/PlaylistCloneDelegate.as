package com.kaltura.delegates.playlist
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class PlaylistCloneDelegate extends WebDelegateBase
	{
		public function PlaylistCloneDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
