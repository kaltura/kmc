package com.kaltura.edw.control.commands.thumb
{
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaThumbAsset;
	import com.kaltura.edw.control.commands.KedCommand;

	public class GetThumbAssetCommand extends KedCommand
	{
		private var _thumbnailAsset:ThumbnailWithDimensions;
		
		override public function execute(event:KMvCEvent):void
		{
			_thumbnailAsset = (event as ThumbnailAssetEvent).thumbnailAsset;
			var getThumbAsset:ThumbAssetGet = new ThumbAssetGet(_thumbnailAsset.thumbAsset.id);
			getThumbAsset.addEventListener(KalturaEvent.COMPLETE, result);
			getThumbAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(getThumbAsset);
		}
		
		override public function result(data:Object):void {
			_thumbnailAsset.thumbAsset = data.data as KalturaThumbAsset;
		}
	}
}