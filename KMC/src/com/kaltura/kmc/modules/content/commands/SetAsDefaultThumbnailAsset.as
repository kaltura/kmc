package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.commands.thumbAsset.ThumbAssetSetAsDefault;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.ThumbnailAssetEvent;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaThumbAsset;

	public class SetAsDefaultThumbnailAsset extends KalturaCommand
	{
		private var _defaultThumb:ThumbnailWithDimensions;
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			_defaultThumb = (event as ThumbnailAssetEvent).thumbnailAsset;
			var multiRequest:MultiRequest = new MultiRequest();
			var setDefault:ThumbAssetSetAsDefault = new ThumbAssetSetAsDefault(_defaultThumb.thumbAsset.id);
			multiRequest.addAction(setDefault);
			var listThumbs:ThumbAssetGetByEntryId = new ThumbAssetGetByEntryId(_model.entryDetailsModel.selectedEntry.id);
			multiRequest.addAction(listThumbs);
			
			multiRequest.addEventListener(KalturaEvent.COMPLETE, result);
			multiRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(multiRequest);
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
			var currentThumbsArray:Array = _model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray;
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
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = currentThumbsArray.concat();
		}
	}
}