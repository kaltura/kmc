package com.kaltura.kmc.modules.content.commands.captions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.captionAsset.CaptionAssetGetDownloadUrl;
	import com.kaltura.commands.captionAsset.CaptionAssetGetUrl;
	import com.kaltura.commands.captionAsset.CaptionAssetList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	import com.kaltura.types.KalturaFlavorAssetStatus;
	import com.kaltura.vo.KalturaAsset;
	import com.kaltura.vo.KalturaAssetFilter;
	import com.kaltura.vo.KalturaCaptionAsset;
	import com.kaltura.vo.KalturaCaptionAssetListResponse;

	public class ListCaptionsCommand extends KalturaCommand
	{
		private var _captionsArray:Array;
		/**
		 * array of captions in status ready, request download url only for these captions
		 * */
		private var _readyCaptionsArray:Array;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAssetFilter = new KalturaAssetFilter();
			filter.entryIdEqual = _model.entryDetailsModel.selectedEntry.id;
			var listCaptions:CaptionAssetList = new CaptionAssetList(filter);
			listCaptions.addEventListener(KalturaEvent.COMPLETE, listResult);
			listCaptions.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listCaptions);			
		}
		
		private function listResult(data:Object):void {
			var listResponse:KalturaCaptionAssetListResponse = data.data as KalturaCaptionAssetListResponse;
			if (listResponse) {
				var mr:MultiRequest = new MultiRequest();
				_captionsArray = new Array();
				_readyCaptionsArray = new Array();
				for each (var caption:KalturaCaptionAsset in listResponse.objects) {
					var entryCaption:EntryCaptionVO = new EntryCaptionVO();
					entryCaption.caption = caption;
					entryCaption.serveUrl = _model.context.kc.protocol + _model.context.kc.domain + EntryCaptionVO.serveURL + "/ks/" + _model.context.kc.ks + "/captionAssetId/" + caption.id;
					_captionsArray.push(entryCaption);
					if (caption.status == KalturaFlavorAssetStatus.READY) {
						//TODO should we use cdn? waiting for server to answer it
						var getUrl:CaptionAssetGetUrl = new CaptionAssetGetUrl(caption.id);
						mr.addAction(getUrl);
						_readyCaptionsArray.push(entryCaption);
					}
				}
				
				if (_readyCaptionsArray.length) {
					mr.addEventListener(KalturaEvent.COMPLETE, handleDownloadUrls);
					mr.addEventListener(KalturaEvent.FAILED, fault);
					_model.context.kc.post(mr);
				}
				else //go strait to result
					result(data);
			}
		}
		
		private function handleDownloadUrls(data:Object) : void {
			var urlResult:Array = data.data as Array;
			for (var i:int = 0; i<urlResult.length; i++) {
				if (urlResult[i] is String)
					(_readyCaptionsArray[i] as EntryCaptionVO).downloadUrl = urlResult[i] as String;
			}
			result(data);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.entryDetailsModel.captionsArray = _captionsArray;
			_model.decreaseLoadCounter();
		}
		
	}
}