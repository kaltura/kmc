package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaDropFolder extends BaseFlexVo
	{
		/** 
		* 		* */ 
		public var id : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var partnerId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var name : String;

		/** 
		* 		* */ 
		public var description : String;

		/** 
		* 		* */ 
		public var type : String;

		/** 
		* 		* */ 
		public var status : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var ingestionProfileId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var dc : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var path : String;

		/** 
		* 		* */ 
		public var slugField : String;

		/** 
		* 		* */ 
		public var slugRegex : String;

		/** 
		* 		* */ 
		public var fileSizeCheckInterval : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var unmatchedFilePolicy : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var fileDeletePolicy : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var autoFileDeleteDays : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var createdAt : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var updatedAt : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		* */ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('name');
			arr.push('description');
			arr.push('type');
			arr.push('status');
			arr.push('ingestionProfileId');
			arr.push('dc');
			arr.push('path');
			arr.push('slugField');
			arr.push('slugRegex');
			arr.push('fileSizeCheckInterval');
			arr.push('unmatchedFilePolicy');
			arr.push('fileDeletePolicy');
			arr.push('autoFileDeleteDays');
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
