package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.commands.metadata.MetadataAdd;
	import com.kaltura.commands.metadata.MetadataUpdate;
	import com.kaltura.commands.playlist.PlaylistUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.events.MetadataDataEvent;
	import com.kaltura.kmc.modules.content.events.SearchEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.kmc.modules.content.utils.MetadataDataParser;
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	/**
	 * This class is the CAirngorm command for updating entries.
	 * */
	public class UpdateEntriesCommand extends KalturaCommand implements ICommand, IResponder {

		private var _entries:ArrayCollection;
		private var _isPlaylist:Boolean;
		private var _closeDrilldown:Boolean;
		private var _displayNextEntry:Boolean;


		override public function execute(event:CairngormEvent):void {
			var e:EntriesEvent = event as EntriesEvent;
			_closeDrilldown = e.closeWindow;
			_displayNextEntry = e.displayNextEntry;
			if (e.entries.length > 50) {
				_entries = e.entries;

				Alert.show(ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesMsgPart1') +
					' ' + _entries.length + ' ' +
					ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesMsgPart2'),
															ResourceManager.getInstance().getString('cms',
																									'updateLotsOfEntriesTitle'),
															Alert.YES | Alert.NO, null, responesFnc);

			}
			else // for small update
			{
				_model.increaseLoadCounter();
				var mr:MultiRequest = new MultiRequest();
				for (var i:uint = 0; i < e.entries.length; i++) {
					var keepId:String = (e.entries[i] as KalturaBaseEntry).id;
					//update custom data
					if (_model.entryDetailsModel.enableUpdateMetadata && !(e.entries[i] is KalturaPlaylist) && _model.entryDetailsModel.metadataInfoArray) {
						for (var j:int = 0; j< _model.entryDetailsModel.metadataInfoArray.length; j++) {
							var metadataInfo:EntryMetadataDataVO = _model.entryDetailsModel.metadataInfoArray[j] as EntryMetadataDataVO;
							var profile:KMCMetadataProfileVO = _model.filterModel.metadataProfiles[j] as KMCMetadataProfileVO;
							if (metadataInfo && profile && profile.profile) {
								var newMetadataXML:XML = MetadataDataParser.toMetadataXML(metadataInfo.metadataDataObject, profile);
								//metadata exists--> update request
								if (metadataInfo.metadata) {
									var originalMetadataXML:XML = new XML(metadataInfo.metadata.xml);
									if (!(MetadataDataParser.compareMetadata(newMetadataXML, originalMetadataXML))) {
										var metadataUpdate:MetadataUpdate = new MetadataUpdate(metadataInfo.metadata.id,
											newMetadataXML.toXMLString());
										mr.addAction(metadataUpdate);
									}
								}
								else if (newMetadataXML.children().length() > 0) {
									var metadataAdd:MetadataAdd = new MetadataAdd(profile.profile.id,
										KalturaMetadataObjectType.ENTRY,
										keepId,
										newMetadataXML.toXMLString());
									mr.addAction(metadataAdd);
								}
							}
						}
						
					}
							
					// only send conversionProfileId if the entry is in no_content status
					if (e.entries[i].status != KalturaEntryStatus.NO_CONTENT) {
						e.entries[i].conversionProfileId = int.MIN_VALUE;
					}
					if (e.entries[i] is KalturaPlaylist) {
						//handle playlist items
						_isPlaylist = true;
						var plE:KalturaPlaylist = e.entries[i] as KalturaPlaylist;
						plE.setUpdatedFieldsOnly(true);
						var updatePlEntry:PlaylistUpdate = new PlaylistUpdate(keepId, plE);
						mr.addAction(updatePlEntry);
					}
					else if (e.entries[i] is KalturaLiveStreamAdminEntry) {
						//handle live stream
						//TODO - atar - why do wee need this?
						var kle:KalturaLiveStreamAdminEntry = e.entries[i] as KalturaLiveStreamAdminEntry;
						kle.setUpdatedFieldsOnly(true);
						var updateEntry:BaseEntryUpdate = new BaseEntryUpdate(keepId, kle);
						mr.addAction(updateEntry);
					}
					else {
						var be:KalturaBaseEntry = e.entries[i] as KalturaBaseEntry;
						be.setUpdatedFieldsOnly(true);
						if(be is KalturaMixEntry)
							(be as KalturaMixEntry).dataContent = null;
						var updateEntry1:BaseEntryUpdate = new BaseEntryUpdate(keepId, be);
						mr.addAction(updateEntry1);
					}
					

				}
				
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
				//update categories
				var updateCategoriesEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				updateCategoriesEvent.dispatch();
				//reload changeble data
				/*if (!_closeDrilldown && !_displayNextEntry) {
					var listCustomData:MetadataDataEvent = new MetadataDataEvent(MetadataDataEvent.LIST)
					listCustomData.dispatch();
				}*/
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
							be.ingestionProfileId = null;
						}
						var updateEntry:BaseEntryUpdate = new BaseEntryUpdate(keepId, be);
						mr.addAction(updateEntry);
					}
					_model.context.kc.post(mr);
				}
			}
			else {
				// announce no update:
				Alert.show(ResourceManager.getInstance().getString('cms', 'noUpdateMadeMsg'),
																   ResourceManager.getInstance().getString('cms',
																										   'noUpdateMadeTitle'));
			}
		}
		

		/**
		 * load success handler
		 * */
		override public function result(data:Object):void {
			super.result(data);
			var searchEvent:SearchEvent;
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
				searchEvent = new SearchEvent(SearchEvent.SEARCH_PLAYLIST, _model.listableVo);
				searchEvent.dispatch();
			}
				// only re-load entries if this is the only popup and will be closed
			else if (_model.popups.length == 1) {
				if (!_closeDrilldown)
					_model.refreshEntriesRequired = true;
				else {
					searchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
					searchEvent.dispatch();
					var categoriesEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
					categoriesEvent.dispatch();
				}
			}
			if (_closeDrilldown) {
				var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
				cgEvent.dispatch();
			}
			else if (!_displayNextEntry){//refresh selected entry
				var entriesArr:Array = data.data as Array;
				//selected entry is the last updated
				_model.entryDetailsModel.selectedEntry = entriesArr[entriesArr.length - 1] as KalturaBaseEntry;
			} 
			_model.decreaseLoadCounter();
		}

	}
}