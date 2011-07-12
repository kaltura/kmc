package com.kaltura.kmc.modules.content.commands.captions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.captionAsset.CaptionAssetGetDownloadUrl;
	import com.kaltura.commands.captionAsset.CaptionAssetList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	import com.kaltura.vo.KalturaAssetFilter;
	import com.kaltura.vo.KalturaCaptionAsset;
	import com.kaltura.vo.KalturaCaptionAssetListResponse;

	public class ListCaptionsCommand extends KalturaCommand
	{
		private var _captionsArray:Array;
		
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
				for each (var caption:KalturaCaptionAsset in listResponse.objects) {
					var entryCaption:EntryCaptionVO = new EntryCaptionVO();
					entryCaption.caption = caption;
					_captionsArray.push(entryCaption);
					var getUrl:CaptionAssetGetDownloadUrl = new CaptionAssetGetDownloadUrl(caption.id, true);
					mr.addAction(getUrl);
				}
				
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
		}
		
		override public function result(data:Object):void {
			var urlResult:Array = data.data as Array;
			for (var i:int = 0; i<urlResult.length; i++) {
				if (urlResult[i] is String)
					(_captionsArray[i] as EntryCaptionVO).downloadUrl = urlResult[i] as String;
			}
			_model.entryDetailsModel.captionsArray = _captionsArray;
			_model.decreaseLoadCounter();
		}
	}
}