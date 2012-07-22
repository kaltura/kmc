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
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.messaging.messages.ErrorMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class DeleteEntriesCommand extends KalturaCommand implements ICommand, IResponder {
		private var _isPlaylist:Boolean = false;
		
		private var _entries:Array;


		override public function execute(event:CairngormEvent):void {
			if (event.data is KalturaBaseEntry) {
				// if an entry was given, use it
				_entries = [event.data];
			}
			else {
				// otherwise use selected entries from the model (bulk action)
				_entries = _model.selectedEntries;
			}
			
			if (_entries.length == 0) {
//				if (_isPlaylist) {
//					Alert.show(ResourceManager.getInstance().getString('cms', 'pleaseSelectPlaylistsFirst'),
//						ResourceManager.getInstance().getString('cms',
//						'pleaseSelectPlaylistsFirstTitle'));
//				} 
//				else {
					Alert.show(ResourceManager.getInstance().getString('entrytable', 'pleaseSelectEntriesFirst'),
						ResourceManager.getInstance().getString('cms',
						'pleaseSelectEntriesFirstTitle'));
//				}
				return;
			} 
			_isPlaylist = (_entries[0] is KalturaPlaylist);
			if (_entries.length < 13) {
				var entryNames:String = "\n";
				for (var i:int = 0; i < _entries.length; i++)
					entryNames += (i + 1) + ". " + _entries[i].name + "\n";


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
		 * Delete _entries entries with a multi request
		 */
		private function deleteEntries(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				_model.increaseLoadCounter();
				var mr:MultiRequest = new MultiRequest();
				for (var i:uint = 0; i < _entries.length; i++) {
					var deleteEntry:KalturaCall;
					// create the correct delete action by entry type, and track deletion.
					if (_entries[i] is KalturaPlaylist) {
						deleteEntry = new PlaylistDelete((_entries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_PLAYLIST,
							"Playlists>DeletePlaylist", _entries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_PLAYLIST, GoogleAnalyticsConsts.CONTENT);
					} else if (_entries[i] is KalturaMixEntry) {
						deleteEntry = new MixingDelete((_entries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_MIX,
							"Delete Mix", _entries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_MIX, GoogleAnalyticsConsts.CONTENT);
					} else {
						deleteEntry = new BaseEntryDelete((_entries[i] as KalturaBaseEntry).id);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT, KalturaStatsKmcEventType.CONTENT_DELETE_ITEM,
							"Delete Entry", _entries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_ITEM, GoogleAnalyticsConsts.CONTENT);
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
			var erHeader:String = _isPlaylist ?  rm.getString('cms', 'deletePlaylists') : rm.getString('cms', 'deleteEntries');
			if (!checkError(data, erHeader)) {
				if (_isPlaylist) {
					Alert.show(rm.getString('cms', 'playlistsDeleted'), erHeader, 4, null, refresh);
				} else {
					Alert.show(rm.getString('cms', 'entriesDeleted'), erHeader, 4, null, refresh);
				}
			}
		}


		/**
		 * after server result - refresh the current list
		 */
		private function refresh(event:CloseEvent):void {
			var searchEvent:KMCSearchEvent;
			if (_model.listableVo.filterVo is KalturaMediaEntryFilterForPlaylist) {
				searchEvent = new KMCSearchEvent(KMCSearchEvent.DO_SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			} else if (_entries[0] && _entries[0] is KalturaPlaylist) {
				//refresh the playlist 
				searchEvent = new KMCSearchEvent(KMCSearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
				return;
			} else {
				searchEvent = new KMCSearchEvent(KMCSearchEvent.DO_SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			}

		}
	}
}