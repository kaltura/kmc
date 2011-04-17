package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDistributionProfile;

	[Bindable]
	public dynamic class KalturaMsnDistributionProfile extends KalturaDistributionProfile
	{
		/** 
		* 		* */ 
		public var username : String;

		/** 
		* 		* */ 
		public var password : String;

		/** 
		* 		* */ 
		public var domain : String;

		/** 
		* 		* */ 
		public var csId : String;

		/** 
		* 		* */ 
		public var source : String;

		/** 
		* 		* */ 
		public var metadataProfileId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var movFlavorParamsId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var flvFlavorParamsId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var wmvFlavorParamsId : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('username');
			arr.push('password');
			arr.push('domain');
			arr.push('csId');
			arr.push('source');
			arr.push('metadataProfileId');
			arr.push('movFlavorParamsId');
			arr.push('flvFlavorParamsId');
			arr.push('wmvFlavorParamsId');
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
