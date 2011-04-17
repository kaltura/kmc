package com.kaltura.vo
{
	import com.kaltura.vo.KalturaVerizonDistributionProviderBaseFilter;

	[Bindable]
	public dynamic class KalturaVerizonDistributionProviderFilter extends KalturaVerizonDistributionProviderBaseFilter
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
