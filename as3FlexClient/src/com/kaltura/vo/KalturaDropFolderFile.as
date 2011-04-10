package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaDropFolderFile extends BaseFlexVo
	{
		public var id : int = int.MIN_VALUE;

		public var partnerId : int = int.MIN_VALUE;

		public var dropFolderId : int = int.MIN_VALUE;

		public var fileName : String;

		public var fileSize : int = int.MIN_VALUE;

		public var lastFileSizeCheckAt : int = int.MIN_VALUE;

		public var status : int = int.MIN_VALUE;

		public var parsedSlug : String;

		public var parsedFlavorId : int = int.MIN_VALUE;

		public var errorDescription : String;

		public var createdAt : int = int.MIN_VALUE;

		public var updatedAt : int = int.MIN_VALUE;

		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('fileSize');
			arr.push('lastFileSizeCheckAt');
			arr.push('status');
			arr.push('parsedSlug');
			arr.push('parsedFlavorId');
			arr.push('errorDescription');
			return arr;
		}
	}
}
