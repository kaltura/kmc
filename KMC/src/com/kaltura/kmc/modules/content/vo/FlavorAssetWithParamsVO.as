package com.kaltura.kmc.modules.content.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	public class FlavorAssetWithParamsVO implements IValueObject
	{
		public var hasOriginal:Boolean = false;
		public var kalturaFlavorAssetWithParams:KalturaFlavorAssetWithParams;
		
		public function FlavorAssetWithParamsVO()
		{
		}

	}
}