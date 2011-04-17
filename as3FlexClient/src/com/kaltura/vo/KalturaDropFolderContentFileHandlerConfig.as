package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDropFolderFileHandlerConfig;

	[Bindable]
	public dynamic class KalturaDropFolderContentFileHandlerConfig extends KalturaDropFolderFileHandlerConfig
	{
		/** 
		* 		* */ 
		public var contentMatchPolicy : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var slugRegex : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('contentMatchPolicy');
			arr.push('slugRegex');
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
