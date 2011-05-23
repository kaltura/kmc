package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.vo.ConversionProfileWithFlavorParamsVo;
	import com.kaltura.types.KalturaConversionProfileOrderBy;
	import com.kaltura.vo.KalturaAssetParams;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
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
			
			//TODO list the new thing

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
			// result
			else {
				// conversion profiles
				var profs:Array = (event.data[0] as KalturaConversionProfileListResponse).objects;
				// flavor params
				var params:Array = (event.data[1] as KalturaFlavorParamsListResponse).objects;
				var tempArrCol:ArrayCollection = new ArrayCollection();

				for each (var cProfile:KalturaConversionProfile in profs) {
					var cp:ConversionProfileWithFlavorParamsVo = new ConversionProfileWithFlavorParamsVo();
					cp.profile = cProfile;
					addFlavorParams(cp, params);
					tempArrCol.addItem(cp);
				}
				_model.entryDetailsModel.conversionProfsWFlavorParams = tempArrCol;
			}	
			_model.decreaseLoadCounter();
		}
			
		protected function addFlavorParams(cp:ConversionProfileWithFlavorParamsVo, params:Array):void {
			var paramsIds:Array = cp.profile.flavorParamsIds.split(",");
			for (var i:int =0; i<paramsIds.length; i++) {
				for each (var param:Object in params) {
					if (param is KalturaFlavorParams && param.id == paramsIds[i]) {
						//TODO only add if not converted flavor
						cp.flavors.addItem(param);
						break;
					}
				}
			}
		}
	}
}