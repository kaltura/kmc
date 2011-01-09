package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.vo.FlavorAssetWithParamsVO;
	import com.kaltura.commands.flavorAsset.FlavorAssetGetFlavorAssetsWithParams;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListFlavorAssetsByEntryIdCommand extends KalturaCommand implements ICommand, IResponder {
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var entryId:String = (event as EntryEvent).entryVo.id;
			var getAssetsAndFlavorsByEntryId:FlavorAssetGetFlavorAssetsWithParams = new FlavorAssetGetFlavorAssetsWithParams(entryId);
			getAssetsAndFlavorsByEntryId.addEventListener(KalturaEvent.COMPLETE, result);
			getAssetsAndFlavorsByEntryId.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getAssetsAndFlavorsByEntryId);


		}


		override public function fault(info:Object):void {
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('cms', 'flavorAssetsErrorMsg') + ":\n" + info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
		}


		override public function result(event:Object):void {
			super.result(event);
			setDataInModel((event as KalturaEvent).data as Array);
			_model.decreaseLoadCounter();
		}


		private function setDataInModel(arrCol:Array):void {
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
	}
}