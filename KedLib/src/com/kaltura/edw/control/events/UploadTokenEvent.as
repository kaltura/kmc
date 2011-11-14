package com.kaltura.edw.control.events
{
	import com.kaltura.edw.vo.AssetVO;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	import flash.net.FileReference;
	
	public class UploadTokenEvent extends KMvCEvent
	{
		public static const UPLOAD_TOKEN:String = "uploadToken";
		
		public var fileReference:FileReference;
		public var assetVo:AssetVO;
		
		public function UploadTokenEvent(type:String, file_reference:FileReference, asset_vo:AssetVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			fileReference = file_reference;
			assetVo = asset_vo;
			super(type, bubbles, cancelable);
		}
	}
}