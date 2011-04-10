package com.kaltura.vo
{
	import com.kaltura.vo.KalturaFilter;

	[Bindable]
	public dynamic class KalturaDropFolderBaseFilter extends KalturaFilter
	{
		public var idEqual : int = int.MIN_VALUE;

		public var idIn : String;

		public var partnerIdEqual : int = int.MIN_VALUE;

		public var partnerIdIn : String;

		public var nameLike : String;

		public var typeEqual : String;

		public var typeIn : String;

		public var statusEqual : int = int.MIN_VALUE;

		public var statusIn : String;

		public var ingestionProfileIdEqual : int = int.MIN_VALUE;

		public var ingestionProfileIdIn : String;

		public var dcEqual : int = int.MIN_VALUE;

		public var dcIn : String;

		public var pathLike : String;

		public var slugFieldLike : String;

		public var slugRegexLike : String;

		public var createdAtGreaterThanOrEqual : int = int.MIN_VALUE;

		public var createdAtLessThanOrEqual : int = int.MIN_VALUE;

		public var updatedAtGreaterThanOrEqual : int = int.MIN_VALUE;

		public var updatedAtLessThanOrEqual : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('idEqual');
			arr.push('idIn');
			arr.push('partnerIdEqual');
			arr.push('partnerIdIn');
			arr.push('nameLike');
			arr.push('typeEqual');
			arr.push('typeIn');
			arr.push('statusEqual');
			arr.push('statusIn');
			arr.push('ingestionProfileIdEqual');
			arr.push('ingestionProfileIdIn');
			arr.push('dcEqual');
			arr.push('dcIn');
			arr.push('pathLike');
			arr.push('slugFieldLike');
			arr.push('slugRegexLike');
			arr.push('createdAtGreaterThanOrEqual');
			arr.push('createdAtLessThanOrEqual');
			arr.push('updatedAtGreaterThanOrEqual');
			arr.push('updatedAtLessThanOrEqual');
			return arr;
		}
	}
}
