package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadata.MetadataList;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.vo.CustomMetadataDataVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.business.CategoryFormBuilder;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.model.CategoriesModel;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.view.content.Categories;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadata;
	import com.kaltura.vo.KalturaMetadataFilter;
	import com.kaltura.vo.KalturaMetadataListResponse;
	
	import mx.collections.ArrayCollection;
	
	public class ListCategoryMetadataDataCommand extends KalturaCommand
	{
		public function ListCategoryMetadataDataCommand()
		{
			super();
		}
		/**
		 * This command requests the server for the latest valid metadata data, that suits
		 * the current profile id and current profile version
		 * @param event the event that triggered this command
		 * 
		 */		
		override public function execute(event:CairngormEvent):void
		{
			var filterModel:FilterModel = _model.filterModel;
//			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			var catModel:CategoriesModel = _model.categoriesModel;
			if (!filterModel.categoryMetadataProfiles || catModel.selectedCategories.length != 1)
				return;
			
			var filter:KalturaMetadataFilter = new KalturaMetadataFilter();
			var selectedCategory:KalturaCategory = catModel.selectedCategories[0] as KalturaCategory;
			filter.objectIdEqual = String(selectedCategory.id);	
			filter.metadataObjectTypeEqual = KalturaMetadataObjectType.CATEGORY;
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
			
//			var cddp:CustomDataDataPack = _model.getDataPack(CustomDataDataPack) as CustomDataDataPack;
//			cddp.metadataInfoArray = new ArrayCollection;
			var filterModel:FilterModel = _model.filterModel;
			var catModel:CategoriesModel = _model.categoriesModel;
			catModel.metadataInfo = new ArrayCollection;
			
			//go over all profiles and match to the metadata data
			for (var i:int = 0; i<filterModel.categoryMetadataProfiles.length; i++) {
				var categoryMetadata:CustomMetadataDataVO = new CustomMetadataDataVO(); 
				catModel.metadataInfo.addItem(categoryMetadata);
				
				// get the form builder that matches this profile:
				var formBuilder:CategoryFormBuilder = filterModel.categoryFormBuilders[i] as CategoryFormBuilder;
				formBuilder.metadataInfo = categoryMetadata;
				
				// add the KalturaMetadata of this profile to the EntryMetadataDataVO
				var profileId:int = (filterModel.categoryMetadataProfiles[i] as KMCMetadataProfileVO).profile.id;
				for each (var metadata:KalturaMetadata in metadataResponse.objects) {
					if (metadata.metadataProfileId == profileId) {
						categoryMetadata.metadata = metadata;
						break;
					}
				}
				formBuilder.updateMultiTags();
			}
		}
	}
}