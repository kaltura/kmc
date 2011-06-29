package com.kaltura.vo
{
	import com.kaltura.vo.KalturaDistributionProfile;

	[Bindable]
	public dynamic class KalturaMyspaceDistributionProfile extends KalturaDistributionProfile
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
		public var metadataProfileId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var myspFlavorParamsId : int = int.MIN_VALUE;

		/** 
		* 		* */ 
		public var feedTitle : String;

		/** 
		* 		* */ 
		public var feedDescription : String;

		/** 
		* 		* */ 
		public var feedContact : String;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('username');
			arr.push('password');
			arr.push('domain');
			arr.push('metadataProfileId');
			arr.push('myspFlavorParamsId');
			arr.push('feedTitle');
			arr.push('feedDescription');
			arr.push('feedContact');
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
