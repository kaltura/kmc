package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.vo.ConversionProfileWithFlavorParamsVo;
	import com.kaltura.types.KalturaAssetParamsOrigin;
	import com.kaltura.types.KalturaConversionProfileOrderBy;
	import com.kaltura.vo.KalturaAssetParams;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsFilter;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
	import flash.profiler.profile;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class ListConversionProfilesAndFlavorParams extends KalturaCommand implements ICommand, IResponder {

		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			var cpFilter:KalturaConversionProfileFilter = new KalturaConversionProfileFilter();
			cpFilter.orderBy = KalturaConversionProfileOrderBy.CREATED_AT_DESC;
			var listConversionProfiles:ConversionProfileList = new ConversionProfileList(cpFilter);

			mr.addAction(listConversionProfiles);

			var listFlavorParams:FlavorParamsList = new FlavorParamsList();
			mr.addAction(listFlavorParams);
			
			var f:KalturaConversionProfileAssetParamsFilter = new KalturaConversionProfileAssetParamsFilter();
			f.originIn = KalturaAssetParamsOrigin.INGEST + "," + KalturaAssetParamsOrigin.CONVERT_WHEN_MISSING;
			var listcpaps:ConversionProfileAssetParamsList = new ConversionProfileAssetParamsList(f);
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
			else if (event.data[0].error) {
				er = event.data[0].error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else if (event.data[1].error) {
				er = event.data[1].error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else if (event.data[2].error) {
				er = event.data[2].error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			// result
			else {
				// conversion profiles
				var profs:Array = (event.data[0] as KalturaConversionProfileListResponse).objects;
				// flavor params
				var params:Array = (event.data[1] as KalturaFlavorParamsListResponse).objects;
				
				var cpaps:Array = (event.data[2] as KalturaConversionProfileAssetParamsListResponse).objects;
				
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
			
		protected function addFlavorParams(cp:ConversionProfileWithFlavorParamsVo, cpaps:Array, params:Array):void {
			var paramsIds:Array = cp.profile.flavorParamsIds.split(",");
			for (var i:int =0; i<paramsIds.length; i++) {
				var cpap:KalturaConversionProfileAssetParams = getCpap(cp.profile.id, paramsIds[i], cpaps);
				if (cpap && cpap.origin != KalturaAssetParamsOrigin.CONVERT) {
					for each (var param:Object in params) {
						if (param is KalturaFlavorParams && param.id == cpap.assetParamsId) {
							//TODO only add if not converted flavor
							cp.flavors.addItem(param);
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