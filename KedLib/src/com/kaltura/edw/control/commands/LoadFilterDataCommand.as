package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.commands.distributionProfile.DistributionProfileList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.business.ClientUtil;
	import com.kaltura.edw.business.IDataOwner;
	import com.kaltura.edw.control.DataTabController;
	import com.kaltura.edw.control.events.LoadEvent;
	import com.kaltura.edw.control.events.MetadataProfileEvent;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.util.FlavorParamsUtil;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.types.KalturaDistributionProfileStatus;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	import com.kaltura.vo.KalturaBaseRestriction;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaDistributionProfileListResponse;
	import com.kaltura.vo.KalturaDistributionThumbDimensions;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	
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
	public class LoadFilterDataCommand extends KedCommand {
		
		public static const DEFAULT_PAGE_SIZE:int = 500;
		
		/**
		 * reference to the filter model in use
		 * */
		private var _filterModel:FilterModel;
		
		/**
		 * the element that triggered the data load.
		 */		
		private var _caller:IDataOwner;
		
		override public function execute(event:KMvCEvent):void {
			_caller = (event as LoadEvent).caller;
			_filterModel = (event as LoadEvent).filterModel;
			
			if (!_filterModel.loadingRequired) {
				_caller.onRequestedDataLoaded();				
				return;
			}
			
			_model.increaseLoadCounter();
			
			var pager:KalturaFilterPager;
			
			// custom data hack
			if (_filterModel.enableCustomData) {
				var lmdp:MetadataProfileEvent = new MetadataProfileEvent(MetadataProfileEvent.LIST);
				DataTabController.getInstance().dispatch(lmdp);
			}
			
			var multiRequest:MultiRequest = new MultiRequest();
			
			// distribution
			if (_filterModel.enableDistribution) {
				pager = new KalturaFilterPager();
				pager.pageSize = DEFAULT_PAGE_SIZE;
				var listDistributionProfile:DistributionProfileList = new DistributionProfileList(null, pager);
				multiRequest.addAction(listDistributionProfile);
			}
			// flavor params
			pager = new KalturaFilterPager();
			pager.pageSize = DEFAULT_PAGE_SIZE;
			var listFlavorParams:FlavorParamsList = new FlavorParamsList(null, pager);
			multiRequest.addAction(listFlavorParams);
			// access control
			var acfilter:KalturaAccessControlFilter = new KalturaAccessControlFilter();
			acfilter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;
			pager = new KalturaFilterPager();
			pager.pageSize = 1000;
			var getListAccessControlProfiles:AccessControlList = new AccessControlList(acfilter, pager);
			multiRequest.addAction(getListAccessControlProfiles);
			
			// listeners
			multiRequest.addEventListener(KalturaEvent.COMPLETE, result);
			multiRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(multiRequest);
		}
	
		override public function result(data:Object):void {
			if (!checkErrors(data)) {
				var responseCount:int = 0;
				
				if (_filterModel.enableDistribution) {
					// distribution
					handleListDistributionProfileResult(data.data[responseCount] as KalturaDistributionProfileListResponse);
					responseCount ++;
				}
				
				// flavor params
				handleFlavorsData(data.data[responseCount] as KalturaFlavorParamsListResponse);
				responseCount ++;
				
				// access control
				handleAccessControls(data.data[responseCount] as KalturaAccessControlListResponse);
				responseCount ++;
				
				_filterModel.loadingRequired = false;
				_caller.onRequestedDataLoaded();
			}
			_model.decreaseLoadCounter();

		}
		
		
		/**
		 * coppied from ListDistributionProfilesCommand 
		 */
		private function handleListDistributionProfileResult(profilesResult:KalturaDistributionProfileListResponse) : void {
			var dum:KalturaDistributionThumbDimensions;
			var profilesArray:Array = new Array();
			//as3flexClient can't generate these objects since we don't include them in the swf 
			for each (var profile:Object in profilesResult.objects) {
				var newProfile:KalturaDistributionProfile;
				if (profile is KalturaDistributionProfile) {
					newProfile = profile as KalturaDistributionProfile;
				}
				else {
					newProfile = ClientUtil.createClassInstanceFromObject(KalturaDistributionProfile, profile);
					//fix bug: simpleXmlEncoder not working properly for nested objects
					if (profile.requiredThumbDimensions is Array)
						newProfile.requiredThumbDimensions = profile.requiredThumbDimensions;
				}
				if (newProfile.status == KalturaDistributionProfileStatus.ENABLED)
					profilesArray.push(newProfile);
			}
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			ddp.distributionInfo.distributionProfiles = profilesArray;
			ddp.distributionInfo.entryDistributions = new Array();
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
				else {
					tempFlavorParamsArr.addItem(FlavorParamsUtil.makeFlavorParams(kFlavor));
				}
			}
			_filterModel.flavorParams = tempFlavorParamsArr;
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
				acVo.id = kac.id;
				if (kac.restrictions) {
					// remove unknown objects
					// if any restriction is unknown, we remove it from the list.
					// this means it is not supported in KMC at the moment
					for (var i:int = 0; i<kac.restrictions.length; i++) {
						if (! (kac.restrictions[i] is KalturaBaseRestriction)) {
							kac.restrictions.splice(i, 1);
						}
					}
				}
				tempArrCol.addItem(acVo);
			}
			_filterModel.accessControlProfiles = tempArrCol;
		}
		
		
		
		private function clearOldFlavorData():void {
			_filterModel.flavorParams.removeAll();
		}
		
	}
}