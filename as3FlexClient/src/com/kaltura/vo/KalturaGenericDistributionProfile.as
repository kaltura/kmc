package com.kaltura.vo
{
	import com.kaltura.vo.KalturaGenericDistributionProfileAction;

	import com.kaltura.vo.KalturaGenericDistributionProfileAction;

	import com.kaltura.vo.KalturaGenericDistributionProfileAction;

	import com.kaltura.vo.KalturaGenericDistributionProfileAction;

	import com.kaltura.vo.KalturaDistributionProfile;

	[Bindable]
	public dynamic class KalturaGenericDistributionProfile extends KalturaDistributionProfile
	{
		public var genericProviderId : int = int.MIN_VALUE;

		public var submitAction : KalturaGenericDistributionProfileAction;

		public var updateAction : KalturaGenericDistributionProfileAction;

		public var deleteAction : KalturaGenericDistributionProfileAction;

		public var fetchReportAction : KalturaGenericDistributionProfileAction;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('submitAction');
			arr.push('updateAction');
			arr.push('deleteAction');
			arr.push('fetchReportAction');
			return arr;
		}
	}
}
