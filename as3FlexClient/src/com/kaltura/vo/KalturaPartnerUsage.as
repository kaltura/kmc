package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaPartnerUsage extends BaseFlexVo
	{
		/** 
		* 		* */ 
		public var hostingGB : Number = NaN;

		/** 
		* 		* */ 
		public var Percent : Number = NaN;

		/** 
		* 		* */ 
		public var packageBW : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var usageGB : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var reachedLimitDate : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var usageGraph : String;

		/** 
		* a list of attributes which may be updated on this object 
		* */ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		* */ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

	}
}
