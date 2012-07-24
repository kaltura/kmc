package com.kaltura.edw.control.commands.thumb
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.commands.thumbAsset.ThumbAssetSetAsDefault;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaThumbAsset;

	public class SetAsDefaultThumbnailAsset extends KedCommand
	{
		private var _defaultThumb:ThumbnailWithDimensions;
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			_defaultThumb = (event as ThumbnailAssetEvent).thumbnailAsset;
			var multiRequest:MultiRequest = new MultiRequest();
			var setDefault:ThumbAssetSetAsDefault = new ThumbAssetSetAsDefault(_defaultThumb.thumbAsset.id);
			multiRequest.addAction(setDefault);
			var listThumbs:ThumbAssetGetByEntryId = new ThumbAssetGetByEntryId((_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry.id);
			multiRequest.addAction(listThumbs);
			
			multiRequest.addEventListener(KalturaEvent.COMPLETE, result);
			multiRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(multiRequest);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			var resultArray:Array = data.data as Array;
			updateThumbnailsState(resultArray[1] as Array);
		}
		
		/**
		 * update our saved array with the updated array arrived from the server 
		 * @param thumbsArray the updated array
		 * 
		 */		
		private function updateThumbnailsState(thumbsArray:Array):void {
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			var currentThumbsArray:Array = ddp.distributionInfo.thumbnailDimensions;
			for (var i:int=0; i<thumbsArray.length; i++) {
				var thumbAsset:KalturaThumbAsset = thumbsArray[i] as KalturaThumbAsset;
				for (var j:int=0; j<currentThumbsArray.length; j++) {
					var thumbWithDimensions:ThumbnailWithDimensions = currentThumbsArray[j] as ThumbnailWithDimensions;
					if (thumbWithDimensions.thumbAsset && (thumbWithDimensions.thumbAsset.id == thumbAsset.id)) {
						thumbWithDimensions.thumbAsset = thumbAsset;
						break;
					}
				}
			}
			
			//for data binding
			ddp.distributionInfo.thumbnailDimensions = currentThumbsArray.concat();
		}
	}
}