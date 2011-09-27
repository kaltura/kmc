package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaThumbAsset;

	public class GetThumbAssetCommand extends KalturaCommand
	{
		private var _thumbnailAsset:ThumbnailWithDimensions;
		
		override public function execute(event:CairngormEvent):void
		{
			_thumbnailAsset = (event as ThumbnailAssetEvent).thumbnailAsset;
			var getThumbAsset:ThumbAssetGet = new ThumbAssetGet(_thumbnailAsset.thumbAsset.id);
			getThumbAsset.addEventListener(KalturaEvent.COMPLETE, result);
			getThumbAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(getThumbAsset);
		}
		
		override public function result(data:Object):void {
			_thumbnailAsset.thumbAsset = data.data as KalturaThumbAsset;
		}
	}
}