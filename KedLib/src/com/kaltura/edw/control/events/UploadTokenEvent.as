package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.vo.AssetVO;
	
	import flash.net.FileReference;
	
	public class UploadTokenEvent extends CairngormEvent
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