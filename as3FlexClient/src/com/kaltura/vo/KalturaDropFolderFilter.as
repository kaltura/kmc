package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDropFolderBaseFilter;

	[Bindable]
	public dynamic class KalturaDropFolderFilter extends KalturaDropFolderBaseFilter
	{
		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			return arr;
		}
	}
}
