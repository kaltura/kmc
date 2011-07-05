package com.kaltura.vo
{
	import com.kaltura.vo.KalturaCuePointFilter;

	[Bindable]
	public dynamic class KalturaAdCuePointBaseFilter extends KalturaCuePointFilter
	{
		/** 
		* 		* */ 
		public var endTimeGreaterThanOrEqual : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var endTimeLessThanOrEqual : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('endTimeGreaterThanOrEqual');
			arr.push('endTimeLessThanOrEqual');
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
