package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTrackerConsts;
	import com.kaltura.commands.playlist.PlaylistAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.types.KalturaPlaylistType;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.utils.SoManager;
	import com.kaltura.vo.KalturaPlaylist;
	import com.kaltura.vo.KalturaPlaylistFilter;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;

	public class AddEntryCommand extends KalturaCommand {
		private var _playListType:Number;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:KMCEntryEvent = event as KMCEntryEvent;
			var addplaylist:PlaylistAdd = new PlaylistAdd(e.entryVo as KalturaPlaylist);
			addplaylist.addEventListener(KalturaEvent.COMPLETE, result);
			addplaylist.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addplaylist);
			_playListType = e.entryVo.playlistType;
			//first time funnel
			if (!SoManager.getInstance().checkOrFlush(GoogleAnalyticsConsts.CONTENT_FIRST_TIME_PLAYLIST_CREATION))
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_FIRST_TIME_PLAYLIST_CREATION, GoogleAnalyticsConsts.CONTENT);
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (_model.listableVo.filterVo is KalturaPlaylistFilter) {
				var searchEvent:KMCSearchEvent = new KMCSearchEvent(KMCSearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
			}
			var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
			cgEvent.dispatch();

			if (_playListType == KalturaPlaylistType.DYNAMIC) {
				KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_ADD_PLAYLIST, "RuleBasedPlayList>AddPlayList" + ">" + data.data.id);
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_ADD_RULEBASED_PLAYLIST, GoogleAnalyticsConsts.CONTENT);
			}
			else if (_playListType == KalturaPlaylistType.STATIC_LIST) {
				KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_ADD_PLAYLIST, "ManuallPlayList>AddPlayList" + ">" + data.data.id);
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_ADD_PLAYLIST, GoogleAnalyticsConsts.CONTENT);
			}

		}
	}
}