package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaFlavorAsset extends BaseFlexVo
	{
		public var id : String;

		public var entryId : String;

		public var partnerId : int = int.MIN_VALUE;

		public var status : int = int.MIN_VALUE;

		public var flavorParamsId : int = int.MIN_VALUE;

		public var version : int = int.MIN_VALUE;

		public var width : int = int.MIN_VALUE;

		public var height : int = int.MIN_VALUE;

		public var bitrate : int = int.MIN_VALUE;

		public var frameRate : int = int.MIN_VALUE;

		public var size : int = int.MIN_VALUE;

		public var isOriginal : Boolean;

		public var tags : String;

		public var isWeb : Boolean;

		public var fileExt : String;

		public var containerFormat : String;

		public var videoCodecId : String;

		public var createdAt : int = int.MIN_VALUE;

		public var updatedAt : int = int.MIN_VALUE;

		public var deletedAt : int = int.MIN_VALUE;

		public var description : String;

public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('isOriginal');
			arr.push('tags');
			arr.push('isWeb');
			arr.push('fileExt');
			arr.push('containerFormat');
			arr.push('videoCodecId');
			arr.push('createdAt');
			arr.push('updatedAt');
			arr.push('deletedAt');
			arr.push('description');
			return arr;
		}
	}
}
