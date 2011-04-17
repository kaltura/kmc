package com.kaltura.vo
{
	import com.kaltura.vo.KalturaMsnDistributionProviderBaseFilter;

	[Bindable]
	public dynamic class KalturaMsnDistributionProviderFilter extends KalturaMsnDistributionProviderBaseFilter
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
