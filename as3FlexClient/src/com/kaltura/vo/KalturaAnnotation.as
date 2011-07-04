package com.kaltura.vo
{
	import com.kaltura.vo.KalturaCuePoint;

	[Bindable]
	public dynamic class KalturaAnnotation extends KalturaCuePoint
	{
		/** 
		* 		* */ 
		public var parentId : String;

		/** 
		* 		* */ 
		public var text : String;

		/** 
		* 		* */ 
		public var endTime : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('parentId');
			arr.push('text');
			arr.push('endTime');
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
