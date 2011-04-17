package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDistributionProfile;

	[Bindable]
	public dynamic class KalturaVerizonDistributionProfile extends KalturaDistributionProfile
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
		public var providerName : String;

		/** 
		* 		* */ 
		public var providerId : String;

		/** 
		* 		* */ 
		public var vrzFlavorParamsId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var metadataProfileId : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('username');
			arr.push('password');
			arr.push('domain');
			arr.push('providerName');
			arr.push('providerId');
			arr.push('vrzFlavorParamsId');
			arr.push('metadataProfileId');
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
