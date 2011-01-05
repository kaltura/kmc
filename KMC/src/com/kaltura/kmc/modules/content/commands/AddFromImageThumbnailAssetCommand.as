package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetAddFromImage;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.UploadFromImageThumbAssetEvent;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaThumbAsset;

	public class AddFromImageThumbnailAssetCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var uploadEvent:UploadFromImageThumbAssetEvent = event as UploadFromImageThumbAssetEvent;
			var uploadFromImage:ThumbAssetAddFromImage = new ThumbAssetAddFromImage(uploadEvent.entryId, uploadEvent.thumbnailFileReference);
			uploadFromImage.addEventListener(KalturaEvent.COMPLETE, result);
			uploadFromImage.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(uploadFromImage);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			insertToThumbsArray(data.data as KalturaThumbAsset);
		}
		
		private function insertToThumbsArray(thumbAsset:KalturaThumbAsset):void {
			var thumbsArray:Array = _model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray;
			var newThumb:ThumbnailWithDimensions = new ThumbnailWithDimensions(thumbAsset.width, thumbAsset.height, thumbAsset);
			newThumb.thumbUrl = _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "&ks=" + _model.context.kc.ks + "&thumbAssetId=" + newThumb.thumbAsset.id;
			for each (var thumb:ThumbnailWithDimensions in thumbsArray) {
				if ((thumb.width==thumbAsset.width) && (thumb.height==thumbAsset.height)) {
					if (!thumb.thumbAsset) {
						thumb.thumbAsset = thumbAsset;
						thumb.thumbUrl = _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "&ks=" + _model.context.kc.ks + "&thumbAssetId=" + thumb.thumbAsset.id;
						//no need to add a new thumbnailWithDimensions object in this case
						return;
					}
					else {
						//since they have the same dimensions: same distribution profiles use them
						newThumb.usedDistributionProfilesArray = thumb.usedDistributionProfilesArray.concat();
					}
					
					break;
				}
			}
			//add to first place
			thumbsArray.splice(0, 0, newThumb); 
			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsArray.concat();	
		}
		
	}
}