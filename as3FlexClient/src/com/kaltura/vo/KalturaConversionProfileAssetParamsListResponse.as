package com.kaltura.vo
{
	import com.kaltura.vo.KalturaConversionProfileAssetParams;

	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaConversionProfileAssetParamsListResponse extends BaseFlexVo
	{
		public var objects : KalturaConversionProfileAssetParams;

		public var totalCount : int = int.MIN_VALUE;

		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}
	}
}
