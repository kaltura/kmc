package com.kaltura.vo
{
	import com.kaltura.vo.KalturaConversionProfileAssetParamsBaseFilter;

	[Bindable]
	public dynamic class KalturaConversionProfileAssetParamsFilter extends KalturaConversionProfileAssetParamsBaseFilter
	{
		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			return arr;
		}

	}
}
