package com.kaltura.vo
{
	import com.kaltura.vo.KalturaAdCuePointBaseFilter;

	[Bindable]
	public dynamic class KalturaAdCuePointFilter extends KalturaAdCuePointBaseFilter
	{
		/** 
		* 		* */ 
		public var providerTypeEqual : String;

		/** 
		* 		* */ 
		public var providerTypeIn : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('providerTypeEqual');
			arr.push('providerTypeIn');
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
