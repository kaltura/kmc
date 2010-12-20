package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaThumbParams;

	public class GenerateThumbAssetEvent extends CairngormEvent
	{
		public static const GENERATE:String = "content_generateThumbAsset";
		public var thumbParams:KalturaThumbParams;
		
		public function GenerateThumbAssetEvent(type:String, thumbParams:KalturaThumbParams , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.thumbParams = thumbParams;
			super(type, bubbles, cancelable);
		}
	}
}