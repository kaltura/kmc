package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetGenerate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.GenerateThumbAssetEvent;
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
			_model.entryDetailsModel.thumbnailSaved = true;
		}
	}
}