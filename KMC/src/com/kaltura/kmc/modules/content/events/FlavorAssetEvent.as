package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	public class FlavorAssetEvent extends CairngormEvent
	{
		public static const CREATE_FLAVOR_ASSET : String = "createFlavorAsset";
		public static const DELETE_FLAVOR_ASSET : String = "deleteFlavorAsset";
		public static const DOWNLOAD_FLAVOR_ASSET : String = "downloadFlavorAsset";
		public static const PREVIEW_FLAVOR_ASSET : String = "previewFlavorAsset";
		
		public function FlavorAssetEvent(type:String, dataVo:KalturaFlavorAssetWithParams, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = dataVo;
		}

	}
}