package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.edw.business.FormBuilder;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.CustomDataDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	public class ListCategoryMetadataProfileCommand extends KalturaCommand
	{
		
		/**
		 * only if a metadata profile view contains layout with this name it will be used
		 */
		private static const KMC_LAYOUT_NAME:String = "KMC";

		
		override public function execute(event:CairngormEvent):void{
			_model.increaseLoadCounter();
			
			var filter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			filter.metadataObjectTypeEqual = KalturaMetadataObjectType.CATEGORY;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, pager);
			listMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
			listMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listMetadataProfile);
		}
		
		override public function result(data:Object):void{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (! checkError(data)){
				var response:KalturaMetadataProfileListResponse = data.data as KalturaMetadataProfileListResponse;
				var metadataProfiles:Array = new Array();
				var formBuilders:Array = new Array();
				if (response.objects) {
					for (var i:int = 0; i < response.objects.length; i++) {
						var recievedProfile:KalturaMetadataProfile = response.objects[i];
						if (recievedProfile) {
							var metadataProfile:KMCMetadataProfileVO = new KMCMetadataProfileVO();
							metadataProfile.profile = recievedProfile;
							metadataProfile.xsd = new XML(recievedProfile.xsd);
							metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);
							
							//set the displayed label of each label
							for each (var field:MetadataFieldVO in metadataProfile.metadataFieldVOArray) {
								var label:String = ResourceManager.getInstance().getString('customFields', field.defaultLabel);
								if (label) {
									field.displayedLabel = label;
								}
								else {
									field.displayedLabel = field.defaultLabel;
								}
							}
							
							//adds the profile to metadataProfiles, and its matching formBuilder to formBuilders
							metadataProfiles.push(metadataProfile);
							var fb:FormBuilder = new FormBuilder(metadataProfile);
							formBuilders.push(fb);
							var isViewExist:Boolean = false;
							
							if (recievedProfile.views) {
								try {
									var recievedView:XML = new XML(recievedProfile.views);
								}
								catch (e:Error) {
									//invalid view xmls
									continue;
								}
								for each (var layout:XML in recievedView.children()) {
									if (layout.@id == KMC_LAYOUT_NAME) {
										metadataProfile.viewXML = layout;
										isViewExist = true;
										continue;
									}
								}
							}
							if (!isViewExist) {
								var cddp:CustomDataDataPack = _model.entryDetailsModel.getDataPack(CustomDataDataPack) as CustomDataDataPack;
								//if no view was retruned, or no view with "KMC" name, we will set the default uiconf XML
								if (cddp.metadataDefaultUiconfXML){
									metadataProfile.viewXML = cddp.metadataDefaultUiconfXML.copy();
								}
								fb.buildInitialMxml();
							}
						}
					}
				}
//				var filterModel:FilterModel = (_model.f getDataPack(FilterDataPack) as FilterDataPack).filterModel;
				var filterModel:FilterModel = _model.filterModel;
				filterModel.categoryMetadataProfiles = new ArrayCollection(metadataProfiles);
				filterModel.categoryFormBuilders = new ArrayCollection(formBuilders);
			}
		}
	}
}