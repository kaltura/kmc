package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTrackerConsts;
	import com.kaltura.commands.playlist.PlaylistAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.control.events.WindowEvent;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.utils.SoManager;
	import com.kaltura.vo.KalturaPlaylist;
	import com.kaltura.vo.KalturaPlaylistFilter;
	
	import mx.rpc.IResponder;

	public class AddEntryCommand extends KalturaCommand implements ICommand, IResponder {
		private var _playListType:Number;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:EntryEvent = event as EntryEvent;
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
			var searchEvent:SearchEvent;
			if (_model.listableVo.filterVo is KalturaPlaylistFilter) {
				searchEvent = new SearchEvent(SearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
			}
			var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
			cgEvent.dispatch();

			if (_playListType == 10) {
				KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_ADD_PLAYLIST, "RuleBasedPlayList>AddPlayList" + ">" + data.data.id);
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_ADD_RULEBASED_PLAYLIST + "/PlayList_id=" + data.data.id, GoogleAnalyticsConsts.CONTENT);
			}
			else if (_playListType == 3) {
				KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_ADD_PLAYLIST, "ManuallPlayList>AddPlayList" + ">" + data.data.id);
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_ADD_PLAYLIST + "/PlayList_id=" + data.data.id, GoogleAnalyticsConsts.CONTENT);
			}

		}
	}
}