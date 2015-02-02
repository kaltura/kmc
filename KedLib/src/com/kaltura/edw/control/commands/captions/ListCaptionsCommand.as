package com.kaltura.edw.control.commands.captions {
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.captionAsset.CaptionAssetGetUrl;
	import com.kaltura.commands.captionAsset.CaptionAssetList;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.CaptionsDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.vo.EntryCaptionVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaCaptionAssetStatus;
	import com.kaltura.types.KalturaFlavorAssetStatus;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaAssetFilter;
	import com.kaltura.vo.KalturaCaptionAsset;
	import com.kaltura.vo.KalturaCaptionAssetListResponse;
	import com.kaltura.vo.KalturaFilterPager;

	public class ListCaptionsCommand extends KedCommand {
		private var _captionsArray:Array;
		/**
		 * array of captions in status ready, request download url only for these captions
		 * */
		private var _readyCaptionsArray:Array;


		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAssetFilter = new KalturaAssetFilter();
			filter.entryIdEqual = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry.id;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = 100;
			var listCaptions:CaptionAssetList = new CaptionAssetList(filter, pager);
			listCaptions.addEventListener(KalturaEvent.COMPLETE, listResult);
			listCaptions.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(listCaptions);
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
					entryCaption.kmcStatus = getKMCStatus(caption);
					entryCaption.serveUrl = _client.protocol + _client.domain + EntryCaptionVO.generalServeURL + "/ks/" + _client.ks + "/captionAssetId/" + caption.id;
					if (caption.isDefault == KalturaNullableBoolean.TRUE_VALUE) {
						entryCaption.isKmcDefault = true;
					}
					_captionsArray.push(entryCaption);
					if (caption.status == KalturaFlavorAssetStatus.READY) {
						var getUrl:CaptionAssetGetUrl = new CaptionAssetGetUrl(caption.id);
						mr.addAction(getUrl);
						_readyCaptionsArray.push(entryCaption);
					}
				}

				if (_readyCaptionsArray.length) {
					mr.addEventListener(KalturaEvent.COMPLETE, handleDownloadUrls);
					mr.addEventListener(KalturaEvent.FAILED, fault);
					_client.post(mr);
				}
				else //go strait to result
					result(data);
			}
		}


		private function getKMCStatus(caption:KalturaCaptionAsset):String {
			var result:String;
			switch (caption.status) {
				case KalturaCaptionAssetStatus.ERROR:
					result = EntryCaptionVO.ERROR;
					break;
				case KalturaCaptionAssetStatus.READY:
					result = EntryCaptionVO.SAVED;
					break;
//				case KalturaCaptionAssetStatus.DELETED:
//				case KalturaCaptionAssetStatus.IMPORTING:
//				case KalturaCaptionAssetStatus.QUEUED:
				default:
					result = EntryCaptionVO.PROCESSING;
					break;
				
			}
			return result;
		}


		private function handleDownloadUrls(data:Object):void {
			var urlResult:Array = data.data as Array;
			for (var i:int = 0; i < urlResult.length; i++) {
				if (urlResult[i] is String)
					(_readyCaptionsArray[i] as EntryCaptionVO).downloadUrl = urlResult[i] as String;
			}
			result(data);
		}


		override public function result(data:Object):void {
			super.result(data);
			
			(_model.getDataPack(CaptionsDataPack) as CaptionsDataPack).captionsArray = _captionsArray;
			_model.decreaseLoadCounter();
		}

	}
}