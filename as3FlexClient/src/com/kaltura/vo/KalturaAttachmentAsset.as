package com.kaltura.vo
{
	import com.kaltura.vo.KalturaAsset;

	[Bindable]
	public dynamic class KalturaAttachmentAsset extends KalturaAsset
	{
		/** 
		* The filename of the attachment asset content		* */ 
		public var filename : String;

		/** 
		* Attachment asset title		* */ 
		public var title : String;

		/** 
		* Friendly description		* */ 
		override public var description : String;

		/** 
		* The attachment format		* */ 
		public var format : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('filename');
			arr.push('title');
			arr.push('description');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			arr.push('format');
			return arr;
		}

	}
}
