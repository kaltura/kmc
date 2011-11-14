package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaThumbParams;

	public class GenerateThumbAssetEvent extends KMvCEvent
	{
		public static const GENERATE:String = "content_generateThumbAsset";
		public var thumbParams:KalturaThumbParams;
		public var thumbSourceId:String;
		
		public function GenerateThumbAssetEvent(type:String, thumbParams:KalturaThumbParams, thumbSourceId:String , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.thumbParams = thumbParams;
			this.thumbSourceId = thumbSourceId;
			super(type, bubbles, cancelable);
		}
	}
}