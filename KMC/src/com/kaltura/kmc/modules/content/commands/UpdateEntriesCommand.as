package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.commands.playlist.PlaylistUpdate;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.KMCSearchEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;

	/**
	 * This class is the Cairngorm command for updating multiple entries, or playlist.
	 * */
	public class UpdateEntriesCommand extends KalturaCommand {

		/**
		 * the updated entries.
		 * */
		private var _entries:ArrayCollection;

		/**
		 * are the entries being updated playlist entries
		 * */
		private var _isPlaylist:Boolean;


		override public function execute(event:CairngormEvent):void {
			var e:EntriesEvent = event as EntriesEvent;
			_entries = e.entries;
			if (e.entries.length > 50) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesMsgPart1') +
					' ' + _entries.length + ' ' +
					ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesMsgPart2'),
					ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesTitle'),
					Alert.YES | Alert.NO, null, responesFnc);

			}
			// for small update
			else {
				_model.increaseLoadCounter();
				var mr:MultiRequest = new MultiRequest();
				for (var i:uint = 0; i < e.entries.length; i++) {
					var keepId:String = (e.entries[i] as KalturaBaseEntry).id;

					// only send conversionProfileId if the entry is in no_content status
					if (e.entries[i].status != KalturaEntryStatus.NO_CONTENT) {
						e.entries[i].conversionProfileId = int.MIN_VALUE;
					}
					
					//handle playlist items
					if (e.entries[i] is KalturaPlaylist) {
						_isPlaylist = true;
						var plE:KalturaPlaylist = e.entries[i] as KalturaPlaylist;
						plE.setUpdatedFieldsOnly(true);
						var updatePlEntry:PlaylistUpdate = new PlaylistUpdate(keepId, plE);
						mr.addAction(updatePlEntry);
					}
					else {
						var be:KalturaBaseEntry = e.entries[i] as KalturaBaseEntry;
						be.setUpdatedFieldsOnly(true);
						if (be is KalturaMixEntry)
							(be as KalturaMixEntry).dataContent = null;
						// don't send categories - we use categoryEntry service to update them in EntryData panel
						be.categories = null;
						be.categoriesIds = null;
						
						var updateEntry1:BaseEntryUpdate = new BaseEntryUpdate(keepId, be);
						mr.addAction(updateEntry1);
					}
				}

				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
				
			}
		}


		/**
		 * alert window closed
		 * */
		private function responesFnc(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				// update:
				var numOfGroups:int = Math.floor(_entries.length / 50);
				var lastGroupSize:int = _entries.length % 50;
				if (lastGroupSize != 0) {
					numOfGroups++;
				}

				var groupSize:int;
				var mr:MultiRequest;
				for (var groupIndex:int = 0; groupIndex < numOfGroups; groupIndex++) {
					mr = new MultiRequest();
					mr.addEventListener(KalturaEvent.COMPLETE, result);
					mr.addEventListener(KalturaEvent.FAILED, fault);

					groupSize = (groupIndex < (numOfGroups - 1)) ? 50 : lastGroupSize;
					for (var entryIndexInGroup:int = 0; entryIndexInGroup < groupSize; entryIndexInGroup++) {
						var index:int = ((groupIndex * 50) + entryIndexInGroup);
						var keepId:String = (_entries[index] as KalturaBaseEntry).id;
						var be:KalturaBaseEntry = _entries[index] as KalturaBaseEntry;
						be.setUpdatedFieldsOnly(true);
						// only send conversionProfileId if the entry is in no_content status
						if (be.status != KalturaEntryStatus.NO_CONTENT) {
							be.conversionProfileId = int.MIN_VALUE;
						}
						// don't send categories - we use categoryEntry service to update them in EntryData panel
						be.categories = null;
						be.categoriesIds = null;
						
						var updateEntry:BaseEntryUpdate = new BaseEntryUpdate(keepId, be);
						mr.addAction(updateEntry);
					}
					_model.context.kc.post(mr);
				}
			}
			else {
				// announce no update:
				Alert.show(ResourceManager.getInstance().getString('cms', 'noUpdateMadeMsg'),
					ResourceManager.getInstance().getString('cms', 'noUpdateMadeTitle'));
			}
		}


		/**
		 * load success handler
		 * */
		override public function result(data:Object):void {
			super.result(data);
			// if updated more than 1 entry, check if any result is error
			if (data.data && data.data is Array) {
				for (var i:uint = 0; i < (data.data as Array).length; i++) {
					if ((data.data as Array)[i] is KalturaError) {
						Alert.show(ResourceManager.getInstance().getString('cms', 'error') + ": " +
							((data.data as Array)[i] as KalturaError).errorMsg);
					}
					else if ((data.data as Array)[i].hasOwnProperty("error")) {
						Alert.show((data.data as Array)[i].error.message, ResourceManager.getInstance().getString('cms', 'error'));
					}
				}
			}

			// refresh playlists list
			if (_isPlaylist) {
				var searchEvent:KMCSearchEvent = new KMCSearchEvent(KMCSearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
				var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
				cgEvent.dispatch();
			}
			_model.decreaseLoadCounter();
		}

	}
}