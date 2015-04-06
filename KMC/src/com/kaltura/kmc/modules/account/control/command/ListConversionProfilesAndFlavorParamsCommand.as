package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.commands.thumbParams.ThumbParamsList;
	import com.kaltura.controls.Paging;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.edw.model.util.FlavorParamsUtil;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.control.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.utils.ListConversionProfilesUtil;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.FlavorVO;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsFilter;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	import com.kaltura.vo.KalturaLiveParams;
	import com.kaltura.vo.KalturaThumbParams;
	import com.kaltura.vo.KalturaThumbParamsListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListConversionProfilesAndFlavorParamsCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();

			_model.loadingFlag = true;

			if (!_model.mediaCPPager) {
				_model.mediaCPPager = new KalturaFilterPager();
			}
			if (event.data) {
				_model.mediaCPPager.pageIndex = event.data[0];
				_model.mediaCPPager.pageSize = event.data[1];
			}
			var listConversionProfiles:ConversionProfileList = new ConversionProfileList(_model.mediaCPFilter, _model.mediaCPPager);
			mr.addAction(listConversionProfiles);
			
			var p:KalturaFilterPager = new KalturaFilterPager();
			p.pageSize = 1000;	// this is a very large number that should be enough to get all items
			var cpapFilter:KalturaConversionProfileAssetParamsFilter = new KalturaConversionProfileAssetParamsFilter();
			cpapFilter.conversionProfileIdFilter = _model.mediaCPFilter;
			var cpaplist:ConversionProfileAssetParamsList = new ConversionProfileAssetParamsList(cpapFilter, p);
			mr.addAction(cpaplist);

			if (_model.mediaFlavorsData.length == 0) {
				// assume this means flavors were not yet loaded, let's load:
				var pager:KalturaFilterPager = new KalturaFilterPager();
				pager.pageSize = ListFlavorsParamsCommand.DEFAULT_PAGE_SIZE;
				var listFlavorParams:FlavorParamsList = new FlavorParamsList(null, pager);
				mr.addAction(listFlavorParams);
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		public function result(event:Object):void {
			var kEvent:KalturaEvent = event as KalturaEvent;
			// error handling
			if (kEvent.data && kEvent.data.length > 0) {
				for (var i:int = 0; i < kEvent.data.length; i++) {
					if (kEvent.data[i].error) {
						var rm:IResourceManager = ResourceManager.getInstance();
						if (kEvent.data[i].error.code == APIErrorCode.SERVICE_FORBIDDEN) {
							Alert.show(rm.getString('common', 'forbiddenError', [kEvent.data[i].error.message]), rm.getString('common', 'forbiden_error_title'));
						}
						else {
							Alert.show(kEvent.data[i].error.message, rm.getString('common', 'forbiden_error_title'));
						}
						_model.loadingFlag = false;
						return;
					}
				}
			}

			// conversion profs
			var convProfilesTmpArrCol:ArrayCollection = new ArrayCollection();
			var convsProfilesRespones:KalturaConversionProfileListResponse = (kEvent.data as Array)[0] as KalturaConversionProfileListResponse;
			for each (var cProfile:KalturaConversionProfile in convsProfilesRespones.objects) {
				var cp:ConversionProfileVO = new ConversionProfileVO();
				cp.profile = cProfile;
				cp.id = cProfile.id.toString();

				if (cp.profile.isDefault) {
					convProfilesTmpArrCol.addItemAt(cp, 0);
				}
				else {
					convProfilesTmpArrCol.addItem(cp);
				}
			}
			
			// conversionProfileAssetParams
			_model.mediaCPAPs = (kEvent.data[1] as KalturaConversionProfileAssetParamsListResponse).objects;
			ListConversionProfilesUtil.addAssetParams(convProfilesTmpArrCol, _model.mediaCPAPs);
			
			// flavors
			var flvorsTmpArrCol:ArrayCollection;
			var liveFlvorsTmpArrCol:ArrayCollection;
			if (_model.mediaFlavorsData.length == 0) {
				flvorsTmpArrCol = new ArrayCollection();
				liveFlvorsTmpArrCol = new ArrayCollection();
				var flavorsResponse:KalturaFlavorParamsListResponse = (kEvent.data as Array)[2] as KalturaFlavorParamsListResponse;
				var flavor:FlavorVO;
				for each (var kFlavor:KalturaFlavorParams in flavorsResponse.objects) {
					// separate live flavorparams from all other flavor params, keep both
					flavor = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					if (kFlavor is KalturaLiveParams) {
						liveFlvorsTmpArrCol.addItem(flavor);
					}
					else {
						flvorsTmpArrCol.addItem(flavor);
					}
				}
				// save live (regular is saved later)
				_model.liveFlavorsData = liveFlvorsTmpArrCol;
			}
			else {
				// take from model
				flvorsTmpArrCol = _model.mediaFlavorsData;
				_model.mediaFlavorsData = null; // refresh
			}
			
			// mark flavors of first profile
			var selectedItems:Array;
			if ((convProfilesTmpArrCol[0] as ConversionProfileVO).profile.flavorParamsIds) {
				// some partner managed to remove all flavors from his default profile, so KMC crashed on this line.
				selectedItems = (convProfilesTmpArrCol[0] as ConversionProfileVO).profile.flavorParamsIds.split(",");
			}
			else {
				selectedItems = new Array();
			}
			
			ListConversionProfilesUtil.selectFlavorParamsByIds(flvorsTmpArrCol, selectedItems);

			_model.mediaFlavorsData = flvorsTmpArrCol;
			_model.totalMediaConversionProfiles = convsProfilesRespones.totalCount; 
			_model.mediaConversionProfiles = convProfilesTmpArrCol;
			_model.loadingFlag = false;
		}


		public function fault(event:Object):void {
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}


	}
}