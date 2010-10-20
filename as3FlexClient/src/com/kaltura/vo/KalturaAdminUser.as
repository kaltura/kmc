package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaAdminUser extends BaseFlexVo
	{
		public var password : String;

		public var email : String;

		public var screenName : String;

public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('screenName');
			return arr;
		}
	}
}
