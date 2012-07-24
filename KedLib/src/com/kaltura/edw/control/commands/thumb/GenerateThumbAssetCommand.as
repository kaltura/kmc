package com.kaltura.edw.control.commands.thumb
{
	import com.kaltura.commands.thumbAsset.ThumbAssetGenerate;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.GenerateThumbAssetEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaThumbAsset;
	import com.kaltura.vo.KalturaThumbParams;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	
	public class GenerateThumbAssetCommand extends KedCommand
	{
		private var _thumbsArray:Array;
		
		private var _ddp:DistributionDataPack;
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			var generateThumbEvent:GenerateThumbAssetEvent = event as GenerateThumbAssetEvent;
			var generateThumbAsset:ThumbAssetGenerate = new ThumbAssetGenerate((_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry.id, generateThumbEvent.thumbParams, generateThumbEvent.thumbSourceId);
			generateThumbAsset.addEventListener(KalturaEvent.COMPLETE, result);
			generateThumbAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(generateThumbAsset);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			_ddp = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			var newThumb:KalturaThumbAsset =  data.data as KalturaThumbAsset;
			_thumbsArray = _ddp.distributionInfo.thumbnailDimensions;
			var curUsedProfiles:Array = new Array();
			var thumbExist:Boolean = false;
			for each (var thumb:ThumbnailWithDimensions in _thumbsArray) {
				if ((newThumb.width == thumb.width) && (newThumb.height == thumb.height)) {
					if (!thumb.thumbAsset) {
						thumb.thumbAsset = newThumb;
						thumb.thumbUrl = thumb.buildThumbUrl(_client);
						thumbExist = true;
						break;
					}
					curUsedProfiles = thumb.usedDistributionProfilesArray;
				}
			}
			if (!thumbExist) {
				var thumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions(newThumb.width, newThumb.height, newThumb);
				thumbToAdd.thumbUrl = thumbToAdd.buildThumbUrl(_client);
				thumbToAdd.usedDistributionProfilesArray = curUsedProfiles;
				//add last
				_thumbsArray.splice(_thumbsArray.length,0,thumbToAdd);
			}
			
			Alert.show(ResourceManager.getInstance().getString('cms','savedMessage'),ResourceManager.getInstance().getString('cms','savedTitle'), Alert.OK, null, onUserOK);
			
		}
		
		/**
		 * only after user approval for the new thumbnail alert, the model will reload the thumbs
		 * */
		private function onUserOK(event:CloseEvent):void {
			_ddp.distributionInfo.thumbnailDimensions = _thumbsArray.concat();
		}
		
	}
}