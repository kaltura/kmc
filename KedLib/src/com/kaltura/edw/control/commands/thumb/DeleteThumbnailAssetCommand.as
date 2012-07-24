package com.kaltura.edw.control.commands.thumb
{
	import com.kaltura.commands.thumbAsset.ThumbAssetDelete;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import mx.collections.ArrayCollection;

	public class DeleteThumbnailAssetCommand extends KedCommand
	{
		private var _thumbToRemove:ThumbnailWithDimensions;
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			_thumbToRemove = (event as ThumbnailAssetEvent).thumbnailAsset;
			var deleteThumb:ThumbAssetDelete = new ThumbAssetDelete(_thumbToRemove.thumbAsset.id);
			deleteThumb.addEventListener(KalturaEvent.COMPLETE, result);
			deleteThumb.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(deleteThumb);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			var thumbsArray:Array = ddp.distributionInfo.thumbnailDimensions;
			for (var i:int = 0; i<thumbsArray.length; i++) {
				var currentThumb:ThumbnailWithDimensions = thumbsArray[i] as ThumbnailWithDimensions;
				if (currentThumb==_thumbToRemove) {
					if (currentThumb.usedDistributionProfilesArray.length > 0) {
						currentThumb.thumbAsset = null;
						currentThumb.thumbUrl = "";
					}
					else 
						thumbsArray.splice(i, 1);
					
					ddp.distributionInfo.thumbnailDimensions = thumbsArray.concat();
					return;
				}
			}			
		}
	}
}