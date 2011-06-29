package com.kaltura.vo
{
	import com.kaltura.vo.KalturaSynacorDistributionProfileBaseFilter;

	[Bindable]
	public dynamic class KalturaSynacorDistributionProfileFilter extends KalturaSynacorDistributionProfileBaseFilter
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
