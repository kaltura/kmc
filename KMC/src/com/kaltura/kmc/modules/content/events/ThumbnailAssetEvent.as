package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ThumbnailAssetEvent extends CairngormEvent
	{
		public static const LIST:String = "content_listThumbnailAsset";
		public static const SET_AS_DEFAULT:String = "content_setAsDefaultThumbAsset";
		public static const DELETE:String = "content_deleteThumbnailAsset";
		
		public var thumbnailAssetId:String;
		
		public function ThumbnailAssetEvent(type:String, thumbAssetId:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			thumbnailAssetId = thumbAssetId;
			super(type, bubbles, cancelable);
		}
	}
}