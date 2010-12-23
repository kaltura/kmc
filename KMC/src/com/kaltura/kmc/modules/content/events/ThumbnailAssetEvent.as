package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;

	public class ThumbnailAssetEvent extends CairngormEvent
	{
		public static const LIST:String = "content_listThumbnailAsset";
		public static const SET_AS_DEFAULT:String = "content_setAsDefaultThumbAsset";
		public static const DELETE:String = "content_deleteThumbnailAsset";
		public static const GET:String = "content_getThumbnailAsset";
		
		public var thumbnailAsset:ThumbnailWithDimensions;
		
		public function ThumbnailAssetEvent(type:String, thumbAsset:ThumbnailWithDimensions = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.thumbnailAsset = thumbAsset;
			super(type, bubbles, cancelable);
		}
	}
}