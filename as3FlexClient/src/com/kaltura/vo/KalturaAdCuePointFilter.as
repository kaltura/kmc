package com.kaltura.vo
{
	import com.kaltura.vo.KalturaAdCuePointBaseFilter;

	[Bindable]
	public dynamic class KalturaAdCuePointFilter extends KalturaAdCuePointBaseFilter
	{
		/** 
		* 		* */ 
		public var protocolTypeEqual : String = null;

		/** 
		* 		* */ 
		public var protocolTypeIn : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('protocolTypeEqual');
			arr.push('protocolTypeIn');
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
