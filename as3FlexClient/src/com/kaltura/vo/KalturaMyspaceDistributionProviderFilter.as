package com.kaltura.vo
{
	import com.kaltura.vo.KalturaMyspaceDistributionProviderBaseFilter;

	[Bindable]
	public dynamic class KalturaMyspaceDistributionProviderFilter extends KalturaMyspaceDistributionProviderBaseFilter
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
