package com.kaltura.vo
{
	import com.kaltura.vo.KalturaBaseJobFilter;

	[Bindable]
	public dynamic class KalturaBatchJobBaseFilter extends KalturaBaseJobFilter
	{
		public var entryIdEqual : String;

		public var jobTypeEqual : int = int.MIN_VALUE;

		public var jobTypeIn : String;

		public var jobTypeNotIn : int = int.MIN_VALUE;

		public var jobSubTypeEqual : int = int.MIN_VALUE;

		public var jobSubTypeIn : String;

		public var onStressDivertToIn : String;

		public var statusEqual : int = int.MIN_VALUE;

		public var statusIn : String;

		public var priorityGreaterThanOrEqual : int = int.MIN_VALUE;

		public var priorityLessThanOrEqual : int = int.MIN_VALUE;

		public var queueTimeGreaterThanOrEqual : int = int.MIN_VALUE;

		public var queueTimeLessThanOrEqual : int = int.MIN_VALUE;

		public var finishTimeGreaterThanOrEqual : int = int.MIN_VALUE;

		public var finishTimeLessThanOrEqual : int = int.MIN_VALUE;

		public var errTypeIn : String;

		public var fileSizeLessThan : int = int.MIN_VALUE;

		public var fileSizeGreaterThan : int = int.MIN_VALUE;

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('entryIdEqual');
			arr.push('jobTypeEqual');
			arr.push('jobTypeIn');
			arr.push('jobTypeNotIn');
			arr.push('jobSubTypeEqual');
			arr.push('jobSubTypeIn');
			arr.push('onStressDivertToIn');
			arr.push('statusEqual');
			arr.push('statusIn');
			arr.push('priorityGreaterThanOrEqual');
			arr.push('priorityLessThanOrEqual');
			arr.push('queueTimeGreaterThanOrEqual');
			arr.push('queueTimeLessThanOrEqual');
			arr.push('finishTimeGreaterThanOrEqual');
			arr.push('finishTimeLessThanOrEqual');
			arr.push('errTypeIn');
			arr.push('fileSizeLessThan');
			arr.push('fileSizeGreaterThan');
			return arr;
		}
	}
}
