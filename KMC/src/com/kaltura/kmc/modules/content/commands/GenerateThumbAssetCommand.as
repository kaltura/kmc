package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetGenerate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.GenerateThumbAssetEvent;
	import com.kaltura.kmc.modules.content.events.ThumbnailAssetEvent;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaThumbAsset;
	import com.kaltura.vo.KalturaThumbParams;
	
	public class GenerateThumbAssetCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var generateThumbEvent:GenerateThumbAssetEvent = event as GenerateThumbAssetEvent;
			var generateThumbAsset:ThumbAssetGenerate = new ThumbAssetGenerate(_model.entryDetailsModel.selectedEntry.id, generateThumbEvent.thumbParams, generateThumbEvent.thumbSourceId);
			generateThumbAsset.addEventListener(KalturaEvent.COMPLETE, result);
			generateThumbAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(generateThumbAsset);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var newThumb:KalturaThumbAsset =  data.data as KalturaThumbAsset;
			var thumbsArray:Array = _model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray;
			var curUsedProfiles:Array = new Array();
			var thumbExist:Boolean = false;
			for each (var thumb:ThumbnailWithDimensions in thumbsArray) {
				if ((newThumb.width == thumb.width) && (newThumb.height == thumb.height)) {
					if (!thumb.thumbAsset) {
						thumb.thumbAsset = newThumb;
						thumb.thumbUrl = buildThumbUrl(newThumb);
						thumbExist = true;
						break;
					}
					curUsedProfiles = thumb.usedDistributionProfilesArray;
				}
			}
			if (!thumbExist) {
				var thumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions(newThumb.width, newThumb.height, newThumb);
				thumbToAdd.thumbUrl = buildThumbUrl(newThumb);
				thumbToAdd.usedDistributionProfilesArray = curUsedProfiles;
				thumbsArray.splice(0,0,thumbToAdd);
			}
			
			_model.entryDetailsModel.thumbnailSaved = true;
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsArray.concat();
		}
		
		private function buildThumbUrl(thumb:KalturaThumbAsset):String {
			return _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "/ks/" + _model.context.kc.ks + "/thumbAssetId/" + thumb.id;
		}
	}
}