package com.kaltura.vo
{
	import com.kaltura.vo.KalturaUserBaseFilter;

	[Bindable]
	public dynamic class KalturaUserFilter extends KalturaUserBaseFilter
	{
		public var loginEnabledEqual : Boolean;

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('loginEnabledEqual');
			return arr;
		}
	}
}
