package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDistributionProfile;

	[Bindable]
	public dynamic class KalturaComcastDistributionProfile extends KalturaDistributionProfile
	{
		/** 
		* 		* */ 
		public var email : String;

		/** 
		* 		* */ 
		public var password : String;

		/** 
		* 		* */ 
		public var account : String;

		/** 
		* 		* */ 
		public var metadataProfileId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var keywords : String;

		/** 
		* 		* */ 
		public var author : String;

		/** 
		* 		* */ 
		public var album : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('email');
			arr.push('password');
			arr.push('account');
			arr.push('metadataProfileId');
			arr.push('keywords');
			arr.push('author');
			arr.push('album');
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
