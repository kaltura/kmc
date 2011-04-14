package com.kaltura.vo
{
	import com.kaltura.vo.KalturaBaseEntry;

	[Bindable]
	public dynamic class KalturaDocumentEntry extends KalturaBaseEntry
	{
		/** 
		* The type of the document		* */ 
		public var documentType : int = int.MIN_VALUE;

		/** 
		* Conversion profile ID to override the default conversion profile
		* */ 
		public var conversionProfileId : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			arr.push('documentType');
			arr.push('conversionProfileId');
			return arr;
		}

	}
}
