package com.kaltura.vo
{
	import com.kaltura.vo.KalturaPermissionItem;

	[Bindable]
	public dynamic class KalturaApiActionPermissionItem extends KalturaPermissionItem
	{
		public var service : String;

		public var action : String;

		public var partnerGroup : String;

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('service');
			arr.push('action');
			arr.push('partnerGroup');
			return arr;
		}
	}
}
