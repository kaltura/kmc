package com.kaltura.edw.control.commands.thumb
{
	import com.kaltura.commands.thumbAsset.ThumbAssetAddFromImage;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.UploadFromImageThumbAssetEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaThumbAsset;

	public class AddFromImageThumbnailAssetCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			var uploadEvent:UploadFromImageThumbAssetEvent = event as UploadFromImageThumbAssetEvent;
			var uploadFromImage:ThumbAssetAddFromImage = new ThumbAssetAddFromImage(uploadEvent.entryId, uploadEvent.thumbnailFileReference);
			uploadFromImage.addEventListener(KalturaEvent.COMPLETE, result);
			uploadFromImage.addEventListener(KalturaEvent.FAILED, fault);
			uploadFromImage.queued = false;
			_client.post(uploadFromImage);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			insertToThumbsArray(data.data as KalturaThumbAsset);
		}
		
		private function buildThumbUrl(thumb:ThumbnailWithDimensions):String {
			return _client.protocol + _client.domain + ThumbnailWithDimensions.serveURL + "/ks/" + _client.ks + "/thumbAssetId/" + thumb.thumbAsset.id;
		}
		
		private function insertToThumbsArray(thumbAsset:KalturaThumbAsset):void {
			var distDp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			var thumbsArray:Array = distDp.distributionProfileInfo.thumbnailDimensionsArray;
			var newThumb:ThumbnailWithDimensions = new ThumbnailWithDimensions(thumbAsset.width, thumbAsset.height, thumbAsset);
			newThumb.thumbUrl = buildThumbUrl(newThumb);
			for each (var thumb:ThumbnailWithDimensions in thumbsArray) {
				if ((thumb.width==thumbAsset.width) && (thumb.height==thumbAsset.height)) {
					if (!thumb.thumbAsset) {
						thumb.thumbAsset = thumbAsset;
						thumb.thumbUrl = buildThumbUrl(thumb)
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
			//add last
			thumbsArray.splice(thumbsArray.length, 0, newThumb); 
			//for data binding
			distDp.distributionProfileInfo.thumbnailDimensionsArray = thumbsArray.concat();	
		}
		
	}
}