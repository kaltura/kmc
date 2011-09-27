package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadata.MetadataList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.business.FormBuilder;
	import com.kaltura.edw.vo.EntryMetadataDataVO;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadata;
	import com.kaltura.vo.KalturaMetadataFilter;
	import com.kaltura.vo.KalturaMetadataListResponse;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * This class sends a metadata data list request to the server and handles the response 
	 * @author Michal
	 * 
	 */	
	public class ListMetadataDataCommand extends KalturaCommand
	{
		
		/**
		 * This command requests the server for the latest valid metadata data, that suits
		 * the current profile id and current profile version
		 * @param event the event that triggered this command
		 * 
		 */		
		override public function execute(event:CairngormEvent):void
		{
			if (!_model.filterModel.metadataProfiles || !_model.entryDetailsModel.selectedEntry.id)
				return;
				
			var filter:KalturaMetadataFilter = new KalturaMetadataFilter();
			filter.objectIdEqual = _model.entryDetailsModel.selectedEntry.id;	
			var pager:KalturaFilterPager = new KalturaFilterPager();
		
			var listMetadataData:MetadataList = new MetadataList(filter, pager);
			listMetadataData.addEventListener(KalturaEvent.COMPLETE, result);
			listMetadataData.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listMetadataData);
		}
		
		/**
		 * This function handles the response returned from the server 
		 * @param data the data returned from the server
		 * 
		 */		
		override public function result(data:Object):void
		{
			super.result(data);
			var metadataResponse:KalturaMetadataListResponse = data.data as KalturaMetadataListResponse;
			
			_model.entryDetailsModel.metadataInfoArray = new ArrayCollection;
			//go over all profiles and match to the metadata data
			for (var i:int = 0; i<_model.filterModel.metadataProfiles.length; i++) {
				var curMetadata:EntryMetadataDataVO = new EntryMetadataDataVO(); 
				_model.entryDetailsModel.metadataInfoArray.addItem(curMetadata);
				var curFormBuilder:FormBuilder = _model.filterModel.formBuilders[i] as FormBuilder;
				curFormBuilder.metadataInfo = curMetadata;
				var curProfile:KMCMetadataProfileVO = _model.filterModel.metadataProfiles[i] as KMCMetadataProfileVO;
				for each (var metadata:KalturaMetadata in metadataResponse.objects) {
					if ((metadata.metadataProfileId == curProfile.profile.id) &&
						(metadata.metadataProfileVersion == curProfile.profile.version)) {
						curMetadata.metadata = metadata;
						break;
					}
				}
				curFormBuilder.updateMultiTags();
			}
		}
		
//		/**
//		 * this function will be called if the request failed 
//		 * @param info the info returned from the server
//		 * 
//		 */		
//		public function fault(info:Object):void
//		{
//			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
//			{
//				JSGate.expired();
//				return;
//			}
//			_model.decreaseLoadCounter();
//			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//		}

	}
}