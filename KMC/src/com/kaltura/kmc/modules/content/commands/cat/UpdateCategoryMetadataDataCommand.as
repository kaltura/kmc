package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.metadata.MetadataAdd;
	import com.kaltura.commands.metadata.MetadataUpdate;
	import com.kaltura.edw.business.MetadataDataParser;
	import com.kaltura.edw.vo.CustomMetadataDataVO;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class UpdateCategoryMetadataDataCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void{
			_model.increaseLoadCounter();
			
			var catid:String = event.data;
			
			var mr:MultiRequest = new MultiRequest();
			
			
			var infoArray:ArrayCollection = _model.categoriesModel.metadataInfo;
			var profileArray:ArrayCollection = _model.filterModel.categoryMetadataProfiles;
			for (var j:int = 0; j < infoArray.length; j++) {
				var metadataInfo:CustomMetadataDataVO = infoArray[j] as CustomMetadataDataVO;
				var profile:KMCMetadataProfileVO = profileArray[j] as KMCMetadataProfileVO;
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
							KalturaMetadataObjectType.CATEGORY,
							catid,
							newMetadataXML.toXMLString());
						mr.addAction(metadataAdd);
					}
				}
			}
			
			// add listeners and post call
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			var isErr:Boolean;
			if (data.data && data.data is Array) {
				for (var i:uint = 0; i < (data.data as Array).length; i++) {
					if ((data.data as Array)[i] is KalturaError) {
						isErr = true;
						Alert.show(ResourceManager.getInstance().getString('drilldown', 'error') + ": " +
							((data.data as Array)[i] as KalturaError).errorMsg);
					}
					else if ((data.data as Array)[i].hasOwnProperty("error")) {
						isErr = true;
						Alert.show((data.data as Array)[i].error.message, ResourceManager.getInstance().getString('drilldown', 'error'));
					}
				}
			}
		}
	}
}