package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	[Bindable]
	public dynamic class KalturaSystemPartnerConfiguration extends BaseFlexVo
	{
		public var host : String;

		public var cdnHost : String;

		public var maxBulkSize : int = int.MIN_VALUE;

		public var partnerPackage : int = int.MIN_VALUE;

		public var liveStreamEnabled : Boolean;

		public var moderateContent : Boolean;

		public var rtmpUrl : String;

		public var storageDeleteFromKaltura : Boolean;

		public var storageServePriority : int = int.MIN_VALUE;

		public var kmcVersion : int = int.MIN_VALUE;

		public var enableAnalyticsTab : Boolean;

		public var enableSilverLight : Boolean;

public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('host');
			arr.push('cdnHost');
			arr.push('maxBulkSize');
			arr.push('partnerPackage');
			arr.push('liveStreamEnabled');
			arr.push('moderateContent');
			arr.push('rtmpUrl');
			arr.push('storageDeleteFromKaltura');
			arr.push('storageServePriority');
			arr.push('kmcVersion');
			arr.push('enableAnalyticsTab');
			arr.push('enableSilverLight');
			return arr;
		}
	}
}
