package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.commands.thumbParams.ThumbParamsList;
	import com.kaltura.controls.Paging;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.account.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.utils.ListConversionProfilesUtil;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.kmc.modules.account.vo.FlavorVO;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
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

			var listThumbParams:ThumbParamsList = new ThumbParamsList();
			mr.addAction(listThumbParams);

			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = ListFlavorsParamsCommand.DEFAULT_PAGE_SIZE;
			var listFlavorParams:FlavorParamsList = new FlavorParamsList(null, pager);
			mr.addAction(listFlavorParams);

			pager = new KalturaFilterPager();
			if (event.data) {
				pager.pageIndex = (event.data as Paging).selectedPage;
				pager.pageSize = (event.data as Paging).pageSize;
			}
			var listConversionProfiles:ConversionProfileList = new ConversionProfileList(_model.cpFilter, pager);
			mr.addAction(listConversionProfiles);
			
			var p:KalturaFilterPager = new KalturaFilterPager();
			p.pageSize = 1000;	// this is a very large number that should be enough to get all items
			var cpaplist:ConversionProfileAssetParamsList = new ConversionProfileAssetParamsList(null, p);
			mr.addAction(cpaplist);

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
			// thumbs
			var thumbResponse:KalturaThumbParamsListResponse = (kEvent.data as Array)[0] as KalturaThumbParamsListResponse;
			_model.thumbsData = new ArrayCollection(thumbResponse.objects);

			// flavors
			var flvorsTmpArrCol:ArrayCollection = new ArrayCollection();
			var flavorsRespones:KalturaFlavorParamsListResponse = (kEvent.data as Array)[1] as KalturaFlavorParamsListResponse;
			for each (var kFlavor:Object in flavorsRespones.objects) {
				if (kFlavor is KalturaFlavorParams) {
					var flavor:FlavorVO = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					flvorsTmpArrCol.addItem(flavor);
				}
			}
			
			// conversion profs
			var convProfilesTmpArrCol:ArrayCollection = new ArrayCollection();
			var convsProfilesRespones:KalturaConversionProfileListResponse = (kEvent.data as Array)[2] as KalturaConversionProfileListResponse;
			for each (var cProfile:KalturaConversionProfile in convsProfilesRespones.objects) {
				var cp:ConversionProfileVO = new ConversionProfileVO();
				cp.profile = cProfile;

				if (cp.profile.isDefault) {
					convProfilesTmpArrCol.addItemAt(cp, 0);
				}
				else {
					convProfilesTmpArrCol.addItem(cp);
				}

			}
			
			// converionProfileAssetParams
			var cpaps:Array = (event.data[3] as KalturaConversionProfileAssetParamsListResponse).objects;
			ListConversionProfilesUtil.addAssetParams(convProfilesTmpArrCol, cpaps);
			
			// mark flavors of first profile
			var selectedItems:Array;
			if ((convProfilesTmpArrCol[0] as ConversionProfileVO).profile.flavorParamsIds) {
				// some partner managed to remove all flavors from his default profile, so KMC crashed on this line.
				selectedItems = (convProfilesTmpArrCol[0] as ConversionProfileVO).profile.flavorParamsIds.split(",");
			}
			else {
				selectedItems = new Array();
			}
			for each (var flavora:String in selectedItems) {
				for each (var flavorVO:FlavorVO in flvorsTmpArrCol) {
					if (flavora == flavorVO.kFlavor.id.toString())
						flavorVO.selected = true;
				}
			}

			_model.flavorsData = flvorsTmpArrCol;
			_model.totalConversionProfiles = convsProfilesRespones.totalCount; 
			_model.conversionData = convProfilesTmpArrCol;
			_model.loadingFlag = false;
		}


		public function fault(event:Object):void {
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}


	}
}