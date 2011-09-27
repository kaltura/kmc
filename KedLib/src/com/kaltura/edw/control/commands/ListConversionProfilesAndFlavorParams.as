package com.kaltura.edw.control.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.vo.ConversionProfileWithFlavorParamsVo;
	import com.kaltura.types.KalturaAssetParamsOrigin;
	import com.kaltura.types.KalturaConversionProfileOrderBy;
	import com.kaltura.vo.KalturaAssetParams;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsFilter;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
	import flash.profiler.profile;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class ListConversionProfilesAndFlavorParams extends KalturaCommand implements ICommand, IResponder {

		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var p:KalturaFilterPager = new KalturaFilterPager();
			p.pageSize = 1000;	// this is a very large number that should be enough to get all items

			var mr:MultiRequest = new MultiRequest();
			if (!_model.entryDetailsModel.conversionProfileLoaded) {
				var cpFilter:KalturaConversionProfileFilter = new KalturaConversionProfileFilter();
				cpFilter.orderBy = KalturaConversionProfileOrderBy.CREATED_AT_DESC;
				var listConversionProfiles:ConversionProfileList = new ConversionProfileList(cpFilter, p);
	
				mr.addAction(listConversionProfiles);
			}

			var listFlavorParams:FlavorParamsList = new FlavorParamsList();
			mr.addAction(listFlavorParams);
			
			var f:KalturaConversionProfileAssetParamsFilter = new KalturaConversionProfileAssetParamsFilter();
			f.originIn = KalturaAssetParamsOrigin.INGEST + "," + KalturaAssetParamsOrigin.CONVERT_WHEN_MISSING;
			var listcpaps:ConversionProfileAssetParamsList = new ConversionProfileAssetParamsList(f, p);
			mr.addAction(listcpaps);

			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		override public function result(event:Object):void {
			// error handling
			var er:KalturaError ;
			if (event.error) {
				er = event.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else {
				for (var i:int = 0; i<event.data.length; i++) {
					if (event.data[i].error) {
						er = event.data[i].error as KalturaError;
						if (er) {
							Alert.show(er.errorMsg, "Error");
						}
					}
				}
			}
			
			// result
			if (!er) {
				var startIndex:int; 
				var profs:Array;
				if (_model.entryDetailsModel.conversionProfileLoaded) {
					startIndex = 0;
					profs = _model.entryDetailsModel.conversionProfiles;
				}
				else {
					startIndex = 1;
					profs = (event.data[0] as KalturaConversionProfileListResponse).objects;
					_model.entryDetailsModel.conversionProfiles = profs;
					_model.entryDetailsModel.conversionProfileLoaded = true;
				}
				// conversion profiles
				// flavor params
				var params:Array = (event.data[startIndex] as KalturaFlavorParamsListResponse).objects;
				
				var cpaps:Array = (event.data[startIndex+1] as KalturaConversionProfileAssetParamsListResponse).objects;
				
				var tempArrCol:ArrayCollection = new ArrayCollection();

				for each (var cProfile:Object in profs) {
					if (cProfile is KalturaConversionProfile) {
						var cp:ConversionProfileWithFlavorParamsVo = new ConversionProfileWithFlavorParamsVo();
						cp.profile = cProfile as KalturaConversionProfile;
						addFlavorParams(cp, cpaps, params);
						tempArrCol.addItem(cp);
					}
				}
				_model.entryDetailsModel.conversionProfsWFlavorParams = tempArrCol;
			}	
			_model.decreaseLoadCounter();
		}
			
		/**
		 * create a list of <code>KalturaConversionProfileAssetParams</code> that belong to 
		 * the conversion profile on the given VO, and add it to the VO.
		 * @param cp		VO to be updated
		 * @param cpaps		objects to filter
		 * @param params	flavor params objects, used for their names.
		 * 
		 */
		protected function addFlavorParams(cp:ConversionProfileWithFlavorParamsVo, cpaps:Array, params:Array):void {
			var profid:int = cp.profile.id;
			for each (var cpap:KalturaConversionProfileAssetParams in cpaps) {
				if (cpap && cpap.conversionProfileId == profid && cpap.origin != KalturaAssetParamsOrigin.CONVERT) {
					for each (var ap:KalturaFlavorParams in params) {
						if (ap && ap.id == cpap.assetParamsId) {
							// add flavor name to the cpap, to be used in dropdown in IR
							cpap.name = ap.name;
							cp.flavors.addItem(cpap);
							break;
						}
					}
				}
			}
		}
		
		
		/**
		 * get cpap by keys 
		 * @param cpid	conversion profile id
		 * @param apid	asset params id
		 * @return 
		 */
		protected function getCpap(cpid:int, apid:int, cpaps:Array):KalturaConversionProfileAssetParams {
			for each (var cpap:KalturaConversionProfileAssetParams in cpaps) {
				if (cpap.assetParamsId == apid && cpap.conversionProfileId == cpid) {
					return cpap;
				}
			}
			return null;
		}
	}
}