package com.kaltura.kmc.modules.content.commands.captions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.captionAsset.CaptionAssetGet;
	import com.kaltura.commands.captionAsset.CaptionAssetGetDownloadUrl;
	import com.kaltura.commands.captionAsset.CaptionAssetGetUrl;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CaptionsEvent;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.captionsComponents.Caption;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	import com.kaltura.types.KalturaFlavorAssetStatus;
	import com.kaltura.vo.KalturaCaptionAsset;
	
	
	public class GetCaptionDownloadUrl extends KalturaCommand
	{
		private var _captionVo:EntryCaptionVO;
		
		/**
		 * Will get the captionAsset, if its status=ready will ask for the updated donwload URL 
		 * @param event
		 * 
		 */		
		override public function execute(event:CairngormEvent):void {
			_captionVo = (event as CaptionsEvent).captionVo;
			if (_captionVo.caption && _captionVo.caption.id) {
				_model.increaseLoadCounter();
				
				var getCaption:CaptionAssetGet = new CaptionAssetGet(_captionVo.caption.id);
				getCaption.addEventListener(KalturaEvent.COMPLETE, captionRecieved);
				getCaption.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(getCaption);
			}
		}
		
		/**
		 * On captionAsset result, will call getDownloadUrl if in status ready 
		 * @param event
		 * 
		 */		
		private function captionRecieved(event:KalturaEvent):void {
			if (event.data is KalturaCaptionAsset) {
				var resultCaption:KalturaCaptionAsset = event.data as KalturaCaptionAsset;
				_captionVo.caption.status = resultCaption.status;
				if (_captionVo.caption.status == KalturaFlavorAssetStatus.READY) {
//					var getUrl:CaptionAssetGetDownloadUrl = new CaptionAssetGetDownloadUrl(_captionVo.caption.id);
					var getUrl:CaptionAssetGetUrl = new CaptionAssetGetUrl(_captionVo.caption.id);
					getUrl.addEventListener(KalturaEvent.COMPLETE, result);
					getUrl.addEventListener(KalturaEvent.FAILED, fault);
					_model.context.kc.post(getUrl);
				}
				else {
					_model.decreaseLoadCounter();
				}
			}
		}
		
		/**
		 * will reset the upload token id since upload has finished
		 * */
		override public function result(data:Object):void {
			super.result(data);
			_captionVo.downloadUrl = data.data as String;
			_captionVo.uploadTokenId = null;
			_model.decreaseLoadCounter();
		}
	}
}