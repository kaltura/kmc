package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.commands.distributionProfile.DistributionProfileList;
	import com.kaltura.commands.entryDistribution.EntryDistributionList;
	import com.kaltura.commands.flavorAsset.FlavorAssetGetFlavorAssetsWithParams;
	import com.kaltura.commands.metadata.MetadataList;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.business.IDataOwner;
	import com.kaltura.kmc.modules.content.events.LoadEvent;
	import com.kaltura.kmc.modules.content.model.EntryDistributionWithProfile;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.kmc.modules.content.utils.FormBuilder;
	import com.kaltura.kmc.modules.content.vo.CategoryVO;
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.kmc.modules.content.vo.FlavorAssetWithParamsVO;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.types.KalturaEntryDistributionStatus;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaDistributionProfileListResponse;
	import com.kaltura.vo.KalturaDistributionThumbDimensions;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.vo.KalturaEntryDistributionFilter;
	import com.kaltura.vo.KalturaEntryDistributionListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	import com.kaltura.vo.KalturaMetadata;
	import com.kaltura.vo.KalturaMetadataFilter;
	import com.kaltura.vo.KalturaMetadataListResponse;
	import com.kaltura.vo.KalturaThumbAsset;
	
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceManager;
	import mx.rpc.xml.SimpleXMLEncoder;

	/**
	 * load all data that is relevant for entry drilldown window:
	 * <lu>
	 * <li>categories</li>
	 * <li>flavor assets by entry id</li>
	 * <li>entry metadata</li>
	 * <li>thumbnail assets</li>
	 * <li>entry distribution</li>
	 * <li>distribution profiles</li>
	 * <li>access control profiles</li>
	 * </lu> 
	 * @author Atar
	 */	
	public class LoadEntryDrilldownDataCommand extends KalturaCommand {
		//TODO take the fault beahvior from all the commands
		
		/**
		 * the element that triggered the data load.
		 */		
		private var _caller:IDataOwner;
		
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_caller = (event as LoadEvent).caller;
			var entryId:String = (event as LoadEvent).entryId; 
			
			var mr:MultiRequest = new MultiRequest();
			
//			categories
			var filter:KalturaMediaEntryFilter = new KalturaMediaEntryFilter();
			filter.statusIn = KalturaEntryStatus.ERROR_CONVERTING + "," + KalturaEntryStatus.ERROR_IMPORTING +
				"," + KalturaEntryStatus.IMPORT + "," + KalturaEntryStatus.PRECONVERT + "," +
				KalturaEntryStatus.READY;
			filter.mediaTypeIn = KalturaMediaType.VIDEO + "," + KalturaMediaType.IMAGE + "," +
				KalturaMediaType.AUDIO + "," + "6" + "," + KalturaMediaType.LIVE_STREAM_FLASH;
			
			// to bypass server defaults
			filter.moderationStatusIn = '';
			
			var getEntryCount:BaseEntryCount = new BaseEntryCount(filter);
			mr.addAction(getEntryCount);
			
			var listCategories:CategoryList = new CategoryList(new KalturaCategoryFilter());
			mr.addAction(listCategories);
			
//			flavor assets by entry id
			var getAssetsAndFlavorsByEntryId:FlavorAssetGetFlavorAssetsWithParams = new FlavorAssetGetFlavorAssetsWithParams(entryId);
			mr.addAction(getAssetsAndFlavorsByEntryId);
			
//			entry metadata
			if (_model.filterModel.enableCustomData &&_model.filterModel && _model.filterModel.metadataProfile && _model.filterModel.metadataProfile.profile && entryId) {
				var filter1:KalturaMetadataFilter = new KalturaMetadataFilter();
				filter1.metadataProfileIdEqual = _model.filterModel.metadataProfile.profile.id;
				filter1.metadataProfileVersionEqual = _model.filterModel.metadataProfile.profile.version;
				filter1.objectIdEqual = entryId;	
				filter1.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
				var pager:KalturaFilterPager = new KalturaFilterPager();
				pager.pageSize = 1;
				pager.pageIndex = 1;
				var listMetadataData:MetadataList = new MetadataList(filter1, pager);
				mr.addAction(listMetadataData);
			}
			
//			thumbnail assets
			var listThumbnailAsset:ThumbAssetGetByEntryId = new ThumbAssetGetByEntryId(entryId);
			mr.addAction(listThumbnailAsset);
			
//			entry distribution
			if (_model.filterModel.enableDistribution)
			{
				//				distribution profiles
				var listDistributionProfile:DistributionProfileList = new DistributionProfileList();
				mr.addAction(listDistributionProfile);
				
				var entryDistributionFilter:KalturaEntryDistributionFilter = new KalturaEntryDistributionFilter();
				entryDistributionFilter.entryIdEqual = entryId;	
				var listEntryDistribution:EntryDistributionList = new EntryDistributionList(entryDistributionFilter);
				mr.addAction(listEntryDistribution);
			

			}
			
//			access control profiles
			var acfilter:KalturaAccessControlFilter = new KalturaAccessControlFilter();
			acfilter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;
			var pager1:KalturaFilterPager = new KalturaFilterPager();
			pager1.pageSize = 1000;
			var listAccessControlProfiles:AccessControlList = new AccessControlList(acfilter, pager1);
			mr.addAction(listAccessControlProfiles);
			
			// listeners
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		
		
		override public function result(data:Object):void {
			var multiRequestIndex : int = 3;
//			categories
			handleCategoriesList(data.data[1] as KalturaCategoryListResponse, data.data[0] as String);
//			flavor assets by entry id
			handleFlavorAssetsByEntryId(data.data[2] as Array);
//			entry metadata
			if (data.data[multiRequestIndex] is KalturaMetadataListResponse) {
				handleMetadata(data.data[multiRequestIndex] as KalturaMetadataListResponse);
				multiRequestIndex++;				
			}
//			thumbnail assets
			handleThumbnailAssets(data.data[multiRequestIndex] as Array);			
			multiRequestIndex++;
			

//			distribution profiles
			if (data.data[multiRequestIndex] is KalturaDistributionProfileListResponse) {
				handleDistributionProfiles(data.data[multiRequestIndex] as KalturaDistributionProfileListResponse);
				multiRequestIndex++
			}
			//			entry distribution
			if (data.data[multiRequestIndex] is KalturaEntryDistributionListResponse) {
				handleEntryDistribution(data.data[multiRequestIndex] as KalturaEntryDistributionListResponse);
				multiRequestIndex++;
			}
//			access control profiles
			handleAccessControls(data.data[multiRequestIndex] as KalturaAccessControlListResponse);
			
			_caller.onRequestedDataLoaded();
			_model.decreaseLoadCounter();
		}
		
		/**
		 * copied from  ListDistributionProfilesCommand
		 */
		private function handleDistributionProfiles(profilesResult:KalturaDistributionProfileListResponse):void {
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
		
		/**
		 * copied from ListEntryDistributionCommand 
		 */
		private function handleEntryDistribution(result:KalturaEntryDistributionListResponse):void {
			var distributionArray:Array = new Array();
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray;
			for each (var distribution:KalturaEntryDistribution in result.objects) {
				if (distribution.status != KalturaEntryDistributionStatus.DELETED) {
					for each (var profile:KalturaDistributionProfile in profilesArray) {
						if (distribution.distributionProfileId == profile.id) {
							var newEntryDistribution:EntryDistributionWithProfile = new EntryDistributionWithProfile();
							newEntryDistribution.kalturaDistributionProfile = profile;
							newEntryDistribution.kalturaEntryDistribution = distribution;
							distributionArray.push(newEntryDistribution);
						} 
					}
				}
			}
			
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = distributionArray;
		}
		
		/**
		 * copied from ListThumbnailAssetCommand 
		 */		
		private function handleThumbnailAssets(thumbsResultArray:Array):void {
			//copy this array so we can delete from it without damage the original profiles array
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray.concat();
			//resets old data
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = new Array();
			buildThumbsWithDimensionsArray(_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray, profilesArray, thumbsResultArray);
		}
		
		/**
		 * this function will aggregate profiles that use the same dimensions with an entry of the same dimensions
		 * */
		private function buildThumbsWithDimensionsArray(thumbsWithDimensionsArray:Array, profilesArray:Array, thumbsArray:Array):void {
			
			//will indicate if the requiredthumbs of these profiles exist
			var isRequiredThumbsExistArray:Array = new Array();
			//initilize with all false values
			for each (var currentProfile:KalturaDistributionProfile in profilesArray) {
				var currentArray:Array = new Array();
				for each (var currentDimension:KalturaDistributionThumbDimensions in currentProfile.requiredThumbDimensions) {
					currentArray.push(false);
				}
				isRequiredThumbsExistArray.push(currentArray);
			}
			
			for each (var currentThumb:KalturaThumbAsset in thumbsArray) {
				var curUsedProfiles:Array = new Array();
				var curThumbExist:Boolean = false;
				//search for thumb with identical dimensions, to copy the used profiles from it
				for each (var existingThumb:ThumbnailWithDimensions in thumbsWithDimensionsArray) {
					if ((currentThumb.width==existingThumb.width) && (currentThumb.height==existingThumb.height)) {
						curUsedProfiles = existingThumb.usedDistributionProfilesArray;
						if (!existingThumb.thumbAsset) {
							existingThumb.thumbAsset = currentThumb;
							existingThumb.thumbUrl = buildThumbUrl(existingThumb);
							curThumbExist = true;
						}
						break;
					}
				}
				//search for all profiles that require the thumb dimensions
				if (curUsedProfiles.length == 0) {
					for (var i:int=profilesArray.length-1; i>=0; i--) {
						var distributionProfile:KalturaDistributionProfile = profilesArray[i] as KalturaDistributionProfile;
						if (distributionProfile.requiredThumbDimensions) {
							for (var j:int=0; j<distributionProfile.requiredThumbDimensions.length; j++) {
								var dim:KalturaDistributionThumbDimensions = distributionProfile.requiredThumbDimensions[j] as KalturaDistributionThumbDimensions;
								if ((dim.width==currentThumb.width) && (dim.height==currentThumb.height)) {
									curUsedProfiles.push(distributionProfile);
									isRequiredThumbsExistArray[i][j] = true;
									break;
								}
							}
							
						}
						/*	for each (var dim:KalturaDistributionThumbDimensions in distributionProfile.requiredThumbDimensions) {
						if ((dim.width==currentThumb.width) && (dim.height==currentThumb.height)) {
						curUsedProfiles.push(distributionProfile);
						isRequiredThumbsExistArray[i] = true;
						break;
						}
						}*/
					}
				}
				//should create new thumbnailWithDimensions object
				if (!curThumbExist) {
					var newThumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions (currentThumb.width,currentThumb.height, currentThumb);
					newThumbToAdd.thumbUrl = buildThumbUrl(newThumbToAdd);
					newThumbToAdd.usedDistributionProfilesArray = curUsedProfiles;
					thumbsWithDimensionsArray.push(newThumbToAdd);
				}			
			}
			
			var remainingProfilesArray:Array = new Array();
			//go over all profiles that don't have matching thumbs
			for (var k:int = 0; k < isRequiredThumbsExistArray.length; k++) {
				var array:Array = isRequiredThumbsExistArray[k] as Array;
				for (var l:int=0; l<array.length; l++) {
					
					if (!array[l]) {
						var profile:KalturaDistributionProfile = profilesArray[k] as KalturaDistributionProfile;
						var requireDimensions:KalturaDistributionThumbDimensions = profile.requiredThumbDimensions[l] as KalturaDistributionThumbDimensions;
						var profileExist:Boolean = false;
						var leftUsedProfiles:Array = new Array();
						for each (var thumbnail:ThumbnailWithDimensions in remainingProfilesArray) {
							if ((thumbnail.width==requireDimensions.width) && (thumbnail.height==requireDimensions.height)) {
								leftUsedProfiles = thumbnail.usedDistributionProfilesArray;
								profileExist = true;
								break;
							}
						}
						if (!profileExist) {
							var thumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions(requireDimensions.width, requireDimensions.height);
							remainingProfilesArray.push(thumbToAdd);
							leftUsedProfiles = thumbToAdd.usedDistributionProfilesArray;		
						}
						leftUsedProfiles.push(profile);
						
					}
				}
			}
			
			thumbsWithDimensionsArray = thumbsWithDimensionsArray.concat(remainingProfilesArray);
			thumbsWithDimensionsArray.sortOn(["width", "height"], Array.NUMERIC);
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsWithDimensionsArray;
		}
		
		private function buildThumbUrl(thumb:ThumbnailWithDimensions):String {
			return _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "&ks=" + _model.context.kc.ks + "&thumbAssetId=" + thumb.thumbAsset.id;
		}
		
		/**
		 * copied from ListMetadataCommand
		 */
		private function handleMetadata(metadataResponse:KalturaMetadataListResponse):void {
			_model.entryDetailsModel.metadataInfo = new EntryMetadataDataVO();
			_model.entryDetailsModel.metadataInfo.metadata = KalturaMetadata(metadataResponse.objects[0]);
			FormBuilder.updateMultiTags();
		}
		
		
		/**
		 * copied from ListCategoriesCommand 
		 */
		private function handleCategoriesList(kclr:KalturaCategoryListResponse, totalEntriesCount:String):void {
			var categories:Array = kclr.objects;
			_model.filterModel.categories = buildCategoriesHyrarchy(categories, totalEntriesCount);
		}
		
		/**
		 * copied fom ListFlavorAssetsByEntryIdCommand 
		 */
		private function handleFlavorAssetsByEntryId(arrCol:Array):void {
			var flavorParamsAndAssetsByEntryId:ArrayCollection = _model.entryDetailsModel.flavorParamsAndAssetsByEntryId;
			flavorParamsAndAssetsByEntryId.removeAll();
			var tempAc:ArrayCollection = new ArrayCollection();
			var foundIsOriginal:Boolean = false;
			for each (var assetWithParam:KalturaFlavorAssetWithParams in arrCol) {
				if ((assetWithParam.flavorAsset != null) && (assetWithParam.flavorAsset.isOriginal)) {
					foundIsOriginal = true;
				}
				var kawp:FlavorAssetWithParamsVO = new FlavorAssetWithParamsVO();
				kawp.kalturaFlavorAssetWithParams = assetWithParam;
				if (assetWithParam.flavorAsset != null) {
					
					flavorParamsAndAssetsByEntryId.addItem(kawp);
				}
				else {
					tempAc.addItem(kawp);
				}
			}
			
			
			for each (var tmpObj:FlavorAssetWithParamsVO in tempAc) {
				flavorParamsAndAssetsByEntryId.addItem(tmpObj);
			}
			
			if (foundIsOriginal) {
				for each (var afwps:FlavorAssetWithParamsVO in flavorParamsAndAssetsByEntryId) {
					afwps.hasOriginal = true;
				}
			}
		}
		
		/**
		 * copied from ListAccessControlsCommand 
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
		
		private function buildCategoriesHyrarchy(array:Array, totalEntryCount:String):CategoryVO {
			var catMap:HashMap = _model.filterModel.categoriesMap;
			catMap.clear();
			
			var root:CategoryVO = new CategoryVO(0,
				ResourceManager.getInstance().getString('cms', 'rootCategoryName'),
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