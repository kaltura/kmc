package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetGetFlavorAssetsWithParams;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.kmc.modules.content.utils.StringUtil;
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAsset;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	import com.kaltura.vo.KalturaMediaEntry;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import com.kaltura.edw.control.commands.KalturaCommand;

	/**
	 * list flavor params for required entry, then open preview&embed with relevant data 
	 * @author Atar
	 */	
	public class ListFlavorAssetsByEntryIdForPreviewCommand extends KalturaCommand {
		
		private var _entry:KalturaBaseEntry;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_entry = (event as EntryEvent).entryVo;
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
			var ac:ArrayCollection = setDataInModel((event as KalturaEvent).data as Array);
			var isHtml5 : Boolean = false;
			if (_entry is KalturaMediaEntry && (_entry as KalturaMediaEntry).mediaType == KalturaMediaType.VIDEO)
			{
				isHtml5 = true;	
			}
			JSGate.doPreviewEmbed(_model.openPlayer, _entry.id, _entry.name, StringUtil.cutTo512Chars(_entry.description),
				!_model.showSingleEntryEmbedCode, false, _model.attic.previewuiconf, null, 
				allFlavorAssets(ac)/*hasMobileFlavors(ac)*/, isHtml5);
			_model.attic.previewuiconf = null;
			_model.decreaseLoadCounter();
		}
		
		
		private function setDataInModel(arr:Array):ArrayCollection {
			var flavorParamsAndAssetsByEntryId:ArrayCollection = new ArrayCollection();
			var tempAc:ArrayCollection = new ArrayCollection();
			var foundIsOriginal:Boolean = false;
			for each (var assetWithParam:KalturaFlavorAssetWithParams in arr) {
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
			return flavorParamsAndAssetsByEntryId;
		}
		
		
		private function allFlavorAssets(flavorParamsAndAssetsByEntryId:ArrayCollection) : Array {
			var fa:KalturaFlavorAsset;
			var result:Array = new Array();
			for each (var kawp:FlavorAssetWithParamsVO in flavorParamsAndAssetsByEntryId) {
				fa = kawp.kalturaFlavorAssetWithParams.flavorAsset;
				if (fa) {
					result.push(fa);
				}
			}
			return result;
		}
		
//		/**
//		 * is any of the given assets a mobile asset?
//		 * */
//		private function hasMobileFlavors(flavorParamsAndAssetsByEntryId:ArrayCollection):Boolean {
//			var result:Boolean = false;
//			var fa:KalturaFlavorAsset;
//			
//			for each (var kawp:FlavorAssetWithParamsVO in flavorParamsAndAssetsByEntryId) {
//				fa = kawp.kalturaFlavorAssetWithParams.flavorAsset; 
//				if (!fa) return false;
//				if(fa.tags.indexOf('iphone') > -1 ){
//					result = true;
//					break;
//				};
//				if(fa.tags.indexOf('ipad') > -1 ){
//					result = true; 
//					break;
//				};
//				if(fa.fileExt == 'ogg' || fa.fileExt == 'ogv' || fa.fileExt == 'oga'){
//					result = true;
//					break;
//				};
//				if(fa.fileExt == '3gp') {
//					result = true;
//					break;
//				};
//			}
//			return result;
//			
//		}

	}
}