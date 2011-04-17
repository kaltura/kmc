package com.kaltura.vo
{
	import com.kaltura.vo.KalturaMsnDistributionProfileBaseFilter;

	[Bindable]
	public dynamic class KalturaMsnDistributionProfileFilter extends KalturaMsnDistributionProfileBaseFilter
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
