package com.kaltura.delegates.playlist
{
	import com.kaltura.commands.playlist.PlaylistGetStatsFromContent;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class PlaylistGetStatsFromContentDelegate extends WebDelegateBase
	{
		public function PlaylistGetStatsFromContentDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
