package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.events.KalturaEvent;

	public class ListThumbnailAssetCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			//var multiRequest:MultiRequest = new MultiRequest();
			
			/*if (_model.entryDetailsModel.enableDistribution && _model.entryDetailsModel.listDistributionProfilesRequired) {
				//add request for profiles
			}*/
			var listThumbnailAsset:ThumbAssetGetByEntryId = new ThumbAssetGetByEntryId(_model.entryDetailsModel.selectedEntry.id);
			listThumbnailAsset.addEventListener(KalturaEvent.COMPLETE, result);
			listThumbnailAsset.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listThumbnailAsset);
			/*multiRequest.addAction(listThumbnailAsset);
			multiRequest.addEventListener(KalturaEvent.COMPLETE, result);
			multiRequest.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(multiRequest);*/
			
		}
		
		override public function result(data:Object):void {
			super.result(data);
		}
	}
}