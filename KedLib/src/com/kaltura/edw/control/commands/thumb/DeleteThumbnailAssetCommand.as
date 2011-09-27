package com.kaltura.edw.control.commands.thumb
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	
	import mx.collections.ArrayCollection;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class DeleteThumbnailAssetCommand extends KalturaCommand
	{
		private var _thumbToRemove:ThumbnailWithDimensions;
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			_thumbToRemove = (event as ThumbnailAssetEvent).thumbnailAsset;
			var deleteThumb:ThumbAssetDelete = new ThumbAssetDelete(_thumbToRemove.thumbAsset.id);
			deleteThumb.addEventListener(KalturaEvent.COMPLETE, result);
			deleteThumb.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(deleteThumb);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var thumbsArray:Array =_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray;
			for (var i:int = 0; i<thumbsArray.length; i++) {
				var currentThumb:ThumbnailWithDimensions = thumbsArray[i] as ThumbnailWithDimensions;
				if (currentThumb==_thumbToRemove) {
					if (currentThumb.usedDistributionProfilesArray.length > 0) {
						currentThumb.thumbAsset = null;
						currentThumb.thumbUrl = "";
					}
					else 
						thumbsArray.splice(i, 1);
					
					_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsArray.concat();
					return;
				}
			}			
		}
	}
}