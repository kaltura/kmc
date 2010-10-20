package com.kaltura.vo
{
	import com.kaltura.vo.KalturaBaseEntry;

	[Bindable]
	public dynamic class KalturaDataEntry extends KalturaBaseEntry
	{
		public var dataContent : String;

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('dataContent');
			return arr;
		}
	}
}
