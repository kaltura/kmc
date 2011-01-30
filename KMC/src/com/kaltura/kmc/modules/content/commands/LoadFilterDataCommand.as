package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.commands.distributionProfile.DistributionProfileList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.business.IDataOwner;
	import com.kaltura.kmc.modules.content.events.LoadEvent;
	import com.kaltura.kmc.modules.content.utils.FormBuilder;
	import com.kaltura.kmc.modules.content.vo.CategoryVO;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaDistributionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceManager;
	import mx.rpc.xml.SimpleXMLEncoder;

	/**
	 * load all data that is relevant for filter:
	 * <lu>
	 * <li>distribution profiles</li>
	 * <li>flavor params</li>
	 * <li>metadata profile</li>
	 * <li>access control profiles</li>
	 * <li>categories</li>
	 * </lu> 
	 * @author Atar
	 * 
	 */	
	public class LoadFilterDataCommand extends KalturaCommand {
		//TODO take the fault beahvior from all the commands (used to show different errors)
		
		/**
		 * the element that triggered the data load.
		 */		
		private var _caller:IDataOwner;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_caller = (event as LoadEvent).caller;
			
			var multiRequest:MultiRequest = new MultiRequest();
			
			// distribution
			if (_model.filterModel.enableDistribution) {
				var listDistributionProfile:DistributionProfileList = new DistributionProfileList();
				multiRequest.addAction(listDistributionProfile);
			}
			// flavor params
			var listFlavorParams:FlavorParamsList = new FlavorParamsList();
			multiRequest.addAction(listFlavorParams);
			// metadata profile
			if (_model.filterModel.enableCustomData) {
				var mpfilter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
				//this configuration will promise that we will work with the latest metadataProfile version
				mpfilter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
				var pager:KalturaFilterPager = new KalturaFilterPager();
				pager.pageSize = 1;
				pager.pageIndex = 1;
				var listMetadataProfile:MetadataProfileList = new MetadataProfileList(mpfilter, pager);
				multiRequest.addAction(listMetadataProfile);
			}
			// access control
			var acfilter:KalturaAccessControlFilter = new KalturaAccessControlFilter();
			acfilter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;
			var pager1:KalturaFilterPager = new KalturaFilterPager();
			pager1.pageSize = 1000;
			var getListAccessControlProfiles:AccessControlList = new AccessControlList(acfilter, pager1);
			multiRequest.addAction(getListAccessControlProfiles);
			
			//categories
			var mefilter:KalturaMediaEntryFilter = new KalturaMediaEntryFilter();
			
			mefilter.statusIn = KalturaEntryStatus.ERROR_CONVERTING + "," + KalturaEntryStatus.ERROR_IMPORTING +
				"," + KalturaEntryStatus.IMPORT + "," + KalturaEntryStatus.PRECONVERT + "," +
				KalturaEntryStatus.READY;
			mefilter.mediaTypeIn = KalturaMediaType.VIDEO + "," + KalturaMediaType.IMAGE + "," +
				KalturaMediaType.AUDIO + "," + "6" + "," + KalturaMediaType.LIVE_STREAM_FLASH;
			
			// to bypass server defaults
			mefilter.moderationStatusIn = '';
			
			var getEntryCount:BaseEntryCount = new BaseEntryCount(mefilter);
			multiRequest.addAction(getEntryCount);
			
			var listCategories:CategoryList = new CategoryList(new KalturaCategoryFilter());
			multiRequest.addAction(listCategories);
			
			
			// listeners
			multiRequest.addEventListener(KalturaEvent.COMPLETE, result);
			multiRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(multiRequest);
		}
	
		override public function result(data:Object):void {
			var responseCount:int = 0;
			
			if (_model.filterModel.enableDistribution) {
				// distribution
				handleListDistributionProfileResult(data.data[responseCount] as KalturaDistributionProfileListResponse);
				responseCount ++;
			}
			
			// flavor params
			handleFlavorsData(data.data[responseCount] as KalturaFlavorParamsListResponse);
			responseCount ++;
			
			if (_model.filterModel.enableCustomData) {
				// metadata profile
				handleMetadataProfile(data.data[responseCount] as KalturaMetadataProfileListResponse);
				responseCount ++;
			}
				
			
			// access control
			handleAccessControls(data.data[responseCount] as KalturaAccessControlListResponse);
			responseCount ++;
			
			// categories
			handleCategoriesList(data.data[(responseCount + 1)] as KalturaCategoryListResponse, data.data[responseCount] as String);
			
			_caller.onRequestedDataLoaded();
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * coppied from ListDistributionProfilesCommand 
		 */
		private function handleListDistributionProfileResult(profilesResult:KalturaDistributionProfileListResponse) : void {
			var profilesArray:Array = new Array();
			//as3flexClient can't generate these objects since we don't include them in the swf 
			for each (var profile:Object in profilesResult.objects) {
				var newProfile:KalturaDistributionProfile = new KClassFactory( KalturaDistributionProfile ).newInstanceFromXML( XMLList(objectToXML(profile)));		
				//fix bug: simpleXmlEncoder not working properly for nested objects
				if (profile.requiredThumbDimensions is Array)
					newProfile.requiredThumbDimensions = profile.requiredThumbDimensions;
				
				profilesArray.push(newProfile);
			}
			_model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray = profilesArray;
		}
		
		
		/**
		 * coppied from ListFlavorsParamsCommand 
		 */
		private function handleFlavorsData(response:KalturaFlavorParamsListResponse):void {
			clearOldFlavorData();
			var tempFlavorParamsArr:ArrayCollection = new ArrayCollection();
			// loop on Object and cast to KalturaFlavorParams so we don't crash on unknown types:
			for each (var kFlavor:Object in response.objects) {
				if (kFlavor is KalturaFlavorParams) {
					tempFlavorParamsArr.addItem(kFlavor);
				}
			}
			_model.filterModel.flavorParams = tempFlavorParamsArr;
		}
		
		
		/**
		 * coppied from ListMetadataProfileCommand 
		 */		
		private function handleMetadataProfile(response:KalturaMetadataProfileListResponse):void {
			var recievedProfile:KalturaMetadataProfile = response.objects[0];
			if (recievedProfile) {
				var metadataProfile:KMCMetadataProfileVO = new KMCMetadataProfileVO();
				metadataProfile.profile = recievedProfile;
				metadataProfile.xsd = new XML(recievedProfile.xsd);
				metadataProfile.metadataFieldVOArray = MetadataProfileParser.fromXSDtoArray(metadataProfile.xsd);
		
				//set the displayed label of each label
				for each (var field:MetadataFieldVO in metadataProfile.metadataFieldVOArray) {
					var label:String = ResourceManager.getInstance().getString('customFields',field.defaultLabel);
					if (label) 
					{
						field.displayedLabel = label;
					}
					else 
					{
						field.displayedLabel = field.defaultLabel;
					}
				}
				
				_model.filterModel.metadataProfile = metadataProfile;
				
				if (recievedProfile.views) {
					try {
						var recievedView:XML = new XML(recievedProfile.views);
					}
					catch (e:Error) {
						//invalid view xmls
						return;
					}
					for each (var layout:XML in recievedView.children()) {
						if (layout.@id == ListMetadataProfileCommand.KMC_LAYOUT_NAME) {
							_model.filterModel.metadataProfile.viewXML = layout;
							return;
							
						}
					}
				}
				
				//if no view was retruned, or no view with "KMC" name, we will set the default uiconf XML
				FormBuilder.setViewXML(_model.entryDetailsModel.metadataDefaultUiconf);
			} 	
			
		}
		
		/**
		 * coppied from ListAccessControlsCommand 
		 */
		private function handleAccessControls(response:KalturaAccessControlListResponse):void {
			var tempArrCol:ArrayCollection = new ArrayCollection();
			for each(var kac:KalturaAccessControl in response.objects)
			{
				var acVo:AccessControlProfileVO = new AccessControlProfileVO();
				acVo.profile = kac;
				tempArrCol.addItem(acVo);
			}
			_model.filterModel.accessControlProfiles = tempArrCol;
		}
		
		/**
		 * coppied from ListCategoriesCommand 
		 */
		private function handleCategoriesList(kclr:KalturaCategoryListResponse, totalEntriesCount:String):void {
			var categories:Array = kclr.objects;
			_model.filterModel.categories = buildCategoriesHyrarchy(categories, totalEntriesCount);
		}
		
		/**
		 * This function will convert a given object to an XML 
		 * @param obj
		 * @return 
		 */		
		private function objectToXML(obj:Object):XML {
			var qName:QName = new QName("root");
			var xmlDocument:XMLDocument = new XMLDocument();
			var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
			var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
			var xml:XML = new XML(xmlDocument.toString());
			return xml;
		}
		
		private function clearOldFlavorData():void {
			_model.filterModel.flavorParams.removeAll();
		}
		
		private function buildCategoriesHyrarchy(array:Array, totalEntryCount:String):CategoryVO {
			var catMap:HashMap = _model.filterModel.categoriesMap;
			catMap.clear();
			
			var root:CategoryVO = new CategoryVO(0,
				ResourceManager.getInstance().getString('cms',
					'rootCategoryName'),
				new KalturaCategory());
			root.category.fullName = '';
			root.category.entriesCount = int(totalEntryCount);
			catMap.put(0 + '', root);
			
			var categories:ArrayCollection = new ArrayCollection();
			
			var categoryNames:ArrayCollection = new ArrayCollection();
			
			var category:CategoryVO;
			var catName:Object;
			for each (var kCat:KalturaCategory in array) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				catName = new Object();
				catName.label = kCat.fullName;
				categoryNames.addItem(catName);
				categories.addItem(category)
			}
			
			_model.entryDetailsModel.categoriesFullNameList = categoryNames;
			
			for each (var cat:CategoryVO in categories) {
				var parentCategory:CategoryVO = catMap.getValue(cat.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
					parentCategory.children.addItem(cat);
					sortCategories(parentCategory.children);
				}
			}
			
			
			return root;
		}
		
		
		private function sortCategories(catArrCol:ArrayCollection):void {
			var dataSortField:SortField = new SortField();
			dataSortField.name = "name";
			dataSortField.caseInsensitive = true;
			dataSortField.descending = false;
			var dataSort:Sort = new Sort();
			dataSort.fields = [dataSortField];
			catArrCol.sort = dataSort;
			catArrCol.refresh();
		}
	}
}