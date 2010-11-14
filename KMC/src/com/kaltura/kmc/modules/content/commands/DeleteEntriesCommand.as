package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.SearchEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class DeleteEntriesCommand extends KalturaCommand implements ICommand, IResponder {
		private var isPlaylist:Boolean = false;


		override public function execute(event:CairngormEvent):void {
			isPlaylist = (event.data == "Playlist");
			if (_model.selectedEntries.length == 0) {
				if (isPlaylist) {
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


				if (isPlaylist) {
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
				if (isPlaylist) {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deleteSelectedPlaylists'),
																	   ResourceManager.getInstance().getString('cms',
																											   'deletePlaylistQTitle'),
																	   Alert.YES | Alert.NO, null,
																	   deleteEntries);
				}
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'deleteSelectedEntries'),
																	   ResourceManager.getInstance().getString('cms',
																											   'deleteEntryQTitle'),
																	   Alert.YES | Alert.NO, null,
																	   deleteEntries);
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
					var deleteEntry:BaseEntryDelete = new BaseEntryDelete((_model.selectedEntries[i] as
						KalturaBaseEntry).id);
					mr.addAction(deleteEntry);

					if (_model.selectedEntries[i] is KalturaPlaylist) {
						KAnalyticsTracker.getInstance().sendEvent(KalturaStatsKmcEventType.CONTENT_DELETE_PLAYLIST,
																  "Playlists>DeletePlaylist",
																  _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_PLAYLIST +
							"/entry_id=" + _model.selectedEntries[i].id,GoogleAnalyticsConsts.CONTENT );
					}
					else if (_model.selectedEntries[i] is KalturaMixEntry) {
						KAnalyticsTracker.getInstance().sendEvent(KalturaStatsKmcEventType.CONTENT_DELETE_MIX,
																  "Delete Mix",
																  _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_MIX +
							"/entry_id=" + _model.selectedEntries[i].id,GoogleAnalyticsConsts.CONTENT);
					}
					else {
						KAnalyticsTracker.getInstance().sendEvent(KalturaStatsKmcEventType.CONTENT_DELETE_ITEM,
																  "Delete Entry",
																  _model.selectedEntries[i].id);
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_DELETE_ITEM +
							"/entry_id=" + _model.selectedEntries[i].id,GoogleAnalyticsConsts.CONTENT);
					}
				}

				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (isPlaylist) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'playlistsDeleted'),
																   ResourceManager.getInstance().getString('cms',
																										   'deletePlaylists'),
																   4, null, refresh);
			}
			else {
				Alert.show(ResourceManager.getInstance().getString('cms', 'entriesDeleted'),
																   ResourceManager.getInstance().getString('cms',
																										   'deleteEntries'),
																   4, null, refresh);
			}
		}


		/**
		 * after server result - refresh the current list
		 */
		private function refresh(event:CloseEvent):void {
			var searchEvent:SearchEvent;
			//TODO - check why need this switch (Eitan) 
			if (_model.listableVo.filterVo is KalturaMediaEntryFilterForPlaylist) {
				searchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			}
			else if (_model.selectedEntries[0] && _model.selectedEntries[0] is KalturaPlaylist) {
				//refresh the playlist 
				searchEvent = new SearchEvent(SearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
			}
			else {
				searchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
				searchEvent.dispatch();
			}


			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();
		}
	}
}