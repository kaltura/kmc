package com.kaltura.edw.control.events
{
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.kmvc.control.KMvCEvent;

	public class ThumbnailAssetEvent extends KMvCEvent
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