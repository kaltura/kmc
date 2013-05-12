package com.kaltura.edw.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	public class FlavorAssetWithParamsVO implements IValueObject
	{
		public var hasOriginal:Boolean = false;
		public var kalturaFlavorAssetWithParams:KalturaFlavorAssetWithParams;
		
		/**
		 * list of flavors (KalturaFlavorParams) that contribute to a multi bitrate flavor
		 */
		public var sources:Array;
		
		public function FlavorAssetWithParamsVO()
		{
		}

	}
}