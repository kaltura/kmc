package com.kaltura.edw.control.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetGetFlavorAssetsWithParams;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.types.KalturaFlavorAssetStatus;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListFlavorAssetsByEntryIdCommand extends KalturaCommand implements ICommand, IResponder {
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_model.entryDetailsModel.flavorsLoaded = false;
			var entryId:String = (event as EntryEvent).entryVo.id;
			var getAssetsAndFlavorsByEntryId:FlavorAssetGetFlavorAssetsWithParams = new FlavorAssetGetFlavorAssetsWithParams(entryId);
			getAssetsAndFlavorsByEntryId.addEventListener(KalturaEvent.COMPLETE, result);
			getAssetsAndFlavorsByEntryId.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getAssetsAndFlavorsByEntryId);
		}


		override public function fault(info:Object):void {
			_model.decreaseLoadCounter();
			if (_model.windowState == WindowsStates.REPLACEMENT_ENTRY_DETAILS_WINDOW) {
				var er:KalturaError = (info as KalturaEvent).error;
				if (er.errorCode == APIErrorCode.ENTRY_ID_NOT_FOUND) {
					Alert.show(ResourceManager.getInstance().getString('cms','replacementNotExistMsg'),ResourceManager.getInstance().getString('cms','replacementNotExistTitle'));
				}		
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'flavorAssetsErrorMsg') + ":\n" + er.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
				}
			}
			else {
				Alert.show(ResourceManager.getInstance().getString('cms', 'flavorAssetsErrorMsg') + ":\n" + info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
			}
		}


		override public function result(event:Object):void {
			super.result(event);
			setDataInModel((event as KalturaEvent).data as Array);
			_model.entryDetailsModel.flavorsLoaded = true;
			_model.decreaseLoadCounter();
		}


		private function setDataInModel(arrCol:Array):void {
			var flavorParamsAndAssetsByEntryId:ArrayCollection = new ArrayCollection();
			flavorParamsAndAssetsByEntryId.removeAll();
			var tempAc:ArrayCollection = new ArrayCollection();
			var foundIsOriginal:Boolean = false;
			for each (var assetWithParam:KalturaFlavorAssetWithParams in arrCol) {
				if (assetWithParam.flavorAsset && assetWithParam.flavorAsset.status == KalturaFlavorAssetStatus.TEMP) {
					// flavor assets will have status temp if it's source of conversion 
					// profile that has no source, during transcoding. we don't want to 
					// show these.
					continue;
				}
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
			_model.entryDetailsModel.flavorParamsAndAssetsByEntryId = flavorParamsAndAssetsByEntryId;
		
		}
	}
}