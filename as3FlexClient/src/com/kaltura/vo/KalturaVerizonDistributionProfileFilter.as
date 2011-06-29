package com.kaltura.vo
{
	import com.kaltura.vo.KalturaVerizonDistributionProfileBaseFilter;

	[Bindable]
	public dynamic class KalturaVerizonDistributionProfileFilter extends KalturaVerizonDistributionProfileBaseFilter
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
