package com.kaltura.edw.control.commands.customData {
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.metadata.MetadataAdd;
	import com.kaltura.commands.metadata.MetadataUpdate;
	import com.kaltura.edw.business.MetadataDataParser;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.MetadataDataEvent;
	import com.kaltura.edw.model.datapacks.CustomDataDataPack;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.model.datapacks.PermissionsDataPack;
	import com.kaltura.edw.vo.CustomMetadataDataVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;

	/**
	 * update current entry's custom data 
	 * @author atarsh
	 *
	 */
	public class UpdateMetadataDataCommand extends KedCommand {

		
		override public function execute(event:KMvCEvent):void {
			// custom data info
			var cddp:CustomDataDataPack = _model.getDataPack(CustomDataDataPack) as CustomDataDataPack;
			// use mr to update metadata for all profiles at once
			var mr:MultiRequest = new MultiRequest();
			var keepId:String = event.data;
			
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
			if (mr.actions.length > 0) {
				_model.increaseLoadCounter();
				// add listeners and post call
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				
				_client.post(mr);
			}
		}


		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			checkErrors(data);
		}

	}
}
