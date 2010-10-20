package com.kaltura.vo
{
	import com.kaltura.vo.KalturaUserBaseFilter;

	[Bindable]
	public dynamic class KalturaUserFilter extends KalturaUserBaseFilter
	{
override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			return arr;
		}
	}
}
