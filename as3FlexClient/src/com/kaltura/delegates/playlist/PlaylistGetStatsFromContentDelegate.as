package com.kaltura.delegates.playlist
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class PlaylistGetStatsFromContentDelegate extends WebDelegateBase
	{
		public function PlaylistGetStatsFromContentDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
