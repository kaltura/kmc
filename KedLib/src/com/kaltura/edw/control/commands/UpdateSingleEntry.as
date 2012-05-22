package com.kaltura.edw.control.commands {
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.commands.metadata.MetadataAdd;
	import com.kaltura.commands.metadata.MetadataUpdate;
	import com.kaltura.edw.business.MetadataDataParser;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.CustomDataDataPack;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.model.datapacks.PermissionsDataPack;
	import com.kaltura.edw.vo.CustomMetadataDataVO;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class UpdateSingleEntry extends KedCommand {
		
		private var _event:KedEntryEvent;

		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			
			_event = event as KedEntryEvent;
			var entry:KalturaBaseEntry = _event.entryVo;

			entry.setUpdatedFieldsOnly(true);
			if (entry.status != KalturaEntryStatus.NO_CONTENT) {
				entry.conversionProfileId = int.MIN_VALUE;
			}
			// don't send categories - we use categoryEntry service to update them in EntryData panel
			entry.categories = null;
			// custom data info
			var cddp:CustomDataDataPack = _model.getDataPack(CustomDataDataPack) as CustomDataDataPack;
			// use mr to update metadata
			var mr:MultiRequest = new MultiRequest();

			var keepId:String = entry.id;

			if ((_model.getDataPack(PermissionsDataPack) as PermissionsDataPack).enableUpdateMetadata && cddp.metadataInfoArray) {
				var metadataProfiles:ArrayCollection = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel.metadataProfiles;
				for (var j:int = 0; j < cddp.metadataInfoArray.length; j++) {
					var metadataInfo:CustomMetadataDataVO = cddp.metadataInfoArray[j] as CustomMetadataDataVO;
					var profile:KMCMetadataProfileVO = metadataProfiles[j] as KMCMetadataProfileVO;
					if (metadataInfo && profile && profile.profile) {
						var newMetadataXML:XML = MetadataDataParser.toMetadataXML(metadataInfo, profile);
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

			var mu:BaseEntryUpdate = new BaseEntryUpdate(entry.id, entry);
			mr.addAction(mu);
			// add listeners and post call
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(mr);


		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (checkErrors(data)) {
				return;
			}
			
			var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_UPDATED);
			e.data = data.data[data.data.length-1]; // send the updated entry as event data
			(_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher.dispatchEvent(e);

			// this will handle window closing or entry switching after successful save
			if (_event.onComplete != null) {
				_event.onComplete.call(_event.source);
			}
			
		}
	}
}