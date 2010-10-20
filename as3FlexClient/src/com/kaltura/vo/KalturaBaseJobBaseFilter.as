package com.kaltura.vo
{
	import com.kaltura.vo.KalturaFilter;

	[Bindable]
	public dynamic class KalturaBaseJobBaseFilter extends KalturaFilter
	{
		public var idEqual : int = int.MIN_VALUE;

		public var idGreaterThanOrEqual : int = int.MIN_VALUE;

		public var partnerIdEqual : int = int.MIN_VALUE;

		public var partnerIdIn : String;

		public var createdAtGreaterThanOrEqual : int = int.MIN_VALUE;

		public var createdAtLessThanOrEqual : int = int.MIN_VALUE;

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('idEqual');
			arr.push('idGreaterThanOrEqual');
			arr.push('partnerIdEqual');
			arr.push('partnerIdIn');
			arr.push('createdAtGreaterThanOrEqual');
			arr.push('createdAtLessThanOrEqual');
			return arr;
		}
	}
}
