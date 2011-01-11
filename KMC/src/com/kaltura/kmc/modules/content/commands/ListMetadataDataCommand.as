package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadata.MetadataList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.utils.FormBuilder;
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadata;
	import com.kaltura.vo.KalturaMetadataFilter;
	import com.kaltura.vo.KalturaMetadataListResponse;
	
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
			if (!_model.filterModel.metadataProfile.profile || !_model.entryDetailsModel.selectedEntry.id)
				return;
				
			var filter:KalturaMetadataFilter = new KalturaMetadataFilter();
			filter.metadataProfileIdEqual = _model.filterModel.metadataProfile.profile.id;
			filter.metadataProfileVersionEqual = _model.filterModel.metadataProfile.profile.version;
			filter.objectIdEqual = _model.entryDetailsModel.selectedEntry.id;	
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = 1;
			pager.pageIndex = 1;
		
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
			_model.entryDetailsModel.metadataInfo = new EntryMetadataDataVO();
			
			var metadataResponse:KalturaMetadataListResponse = KalturaMetadataListResponse(data.data);
			_model.entryDetailsModel.metadataInfo.metadata = KalturaMetadata(metadataResponse.objects[0]);
			FormBuilder.updateMultiTags();
		
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