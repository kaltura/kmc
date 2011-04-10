package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaConversionProfileAssetParams extends BaseFlexVo
	{
		public var conversionProfileId : int = int.MIN_VALUE;

		public var assetParamsId : int = int.MIN_VALUE;

		public var readyBehavior : int = int.MIN_VALUE;

		public var origin : int = int.MIN_VALUE;

		public var systemName : String;

		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('readyBehavior');
			arr.push('origin');
			arr.push('systemName');
			return arr;
		}
	}
}
