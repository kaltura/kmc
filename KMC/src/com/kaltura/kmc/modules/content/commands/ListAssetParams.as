package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileListAssetParams;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.ConversionSettingsEvent;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class ListAssetParams extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var profid:int = parseInt((event as ConversionSettingsEvent).data);
			var lap:ConversionProfileListAssetParams = new ConversionProfileListAssetParams(profid);
			lap.addEventListener(KalturaEvent.COMPLETE, result);
			lap.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(lap);
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				var response:KalturaConversionProfileAssetParamsListResponse = data.data as KalturaConversionProfileAssetParamsListResponse;
				_model.entryDetailsModel.selectedCPAssetParams = new ArrayCollection(response.objects);
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('cms', 'error'));
			}
			
			_model.decreaseLoadCounter();
		}
	}
}