package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTrackerConsts;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryDelete;
	import com.kaltura.commands.mixing.MixingDelete;
	import com.kaltura.commands.playlist.PlaylistDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.SearchEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;

	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class DeleteEntriesCommand extends KalturaCommand implements ICommand, IResponder {
		private var _isPlaylist:Boolean = false;


		override public function execute(event:CairngormEvent):void {
			_isPlaylist = (event.data == "Playlist");
			if (_model.selectedEntries.length == 0) {
				if (_isPlaylist) {
					Alert.show(ResourceManager.getInstance().getString('cms', 'pleaseSelectPlaylistsFirst'),
						ResourceManager.getInstance().getString('cms',
						'pleaseSelectPlaylistsFirstTitle'));
				} 
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'pleaseSelectEntriesFirst'),
						ResourceManager.getInstance().getString('cms',
						'pleaseSelectEntriesFirstTitle'));
				}
				return;
			} 
			else if (_model.selectedEntries.length < 13) {
				var entryNames:String = "\n";
				for (var i:int = 0; i < _model.selectedEntries.length; i++)
					entryNames += (i + 1) + ". " + _model.selectedEntries[i].name + "\n";


				if (_isPlaylist) {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deletePlaylistQ', [entryNames]),
						ResourceManager.getInstance().getString('cms',
						'deletePlaylistQTitle'),
						Alert.YES |
						Alert.NO, null, deleteEntries);
				} 
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deleteEntryQ', [entryNames]),
						ResourceManager.getInstance().getString('cms',
						'deleteEntryQTitle'),
						Alert.YES |
						Alert.NO, null, deleteEntries);
				}
			} 
			else {
				if (_isPlaylist) {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deleteSelectedPlaylists'),
						ResourceManager.getInstance().getString('cms',
						'deletePlaylistQTitle'),
						Alert.YES | Alert.NO, null,
						deleteEntries);
				} 
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deleteSelectedEntries'),
						ResourceManager.getInstance().getString('cms', 'deleteEntryQTitle'),
						Alert.YES | Alert.NO, null, deleteEntries);
				}
			}
		}


		/**
		 * Delete _model.selectedEntries entries with a multi request
		 */
		private function deleteEntries(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				_model.increaseLoadCounter();
				var mr:MultiRequest = new MultiRequest();
				for (var i:uint = 0; i < _model.selectedEntries.length; i++) {
					var deleteEntry:KalturaCall;
					// create the correct delete action by entry type, and track deletion.
					if (_model.selectedEntries[i] is KalturaPlaylist) {
						deleteEntry = new PlaylistDelete((_model.selectedEntries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_PLAYLIST,
							"Playlists>DeletePlaylist", _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_PLAYLIST +
							"/entry_id=" + _model.selectedEntries[i].id, GoogleAnalyticsConsts.CONTENT);
					} else if (_model.selectedEntries[i] is KalturaMixEntry) {
						deleteEntry = new MixingDelete((_model.selectedEntries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_MIX,
							"Delete Mix", _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_MIX +
							"/entry_id=" + _model.selectedEntries[i].id, GoogleAnalyticsConsts.CONTENT);
					} else {
						deleteEntry = new BaseEntryDelete((_model.selectedEntries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_ITEM,
							"Delete Entry", _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_ITEM +
							"/entry_id=" + _model.selectedEntries[i].id, GoogleAnalyticsConsts.CONTENT);
					}

					mr.addAction(deleteEntry);
				}

				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			var rm:IResourceManager = ResourceManager.getInstance();
			if (_isPlaylist) {
				Alert.show(rm.getString('cms', 'playlistsDeleted'),
					rm.getString('cms', 'deletePlaylists'), 4, null, refresh);
			} else {
				Alert.show(rm.getString('cms', 'entriesDeleted'),
					rm.getString('cms', 'deleteEntries'), 4, null, refresh);
			}
		}


		/**
		 * after server result - refresh the current list
		 */
		private function refresh(event:CloseEvent):void {
			var searchEvent:SearchEvent;
			if (_model.listableVo.filterVo is KalturaMediaEntryFilterForPlaylist) {
				searchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			} else if (_model.selectedEntries[0] && _model.selectedEntries[0] is KalturaPlaylist) {
				//refresh the playlist 
				searchEvent = new SearchEvent(SearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
				return;
			} else {
				searchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			}


			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();
		}
	}
}