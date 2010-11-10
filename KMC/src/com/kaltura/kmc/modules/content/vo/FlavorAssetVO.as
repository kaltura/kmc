package com.kaltura.kmc.modules.content.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	import mx.utils.ObjectProxy;
	
	public class FlavorAssetVO extends ObjectProxy implements IValueObject
	{
		public var asset:KalturaFlavorAsset;
		public function FlavorAssetVO()
		{
			asset = new KalturaFlavorAsset();
		}

	}
}