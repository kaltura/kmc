package com.kaltura.vo
{
	import com.kaltura.vo.KalturaMediaEntry;

	[Bindable]
	public dynamic class KalturaLiveStreamEntry extends KalturaMediaEntry
	{
		public var offlineMessage : String;

		public var streamRemoteId : String;

		public var streamRemoteBackupId : String;

		public var bitrates : Array = new Array();

override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('offlineMessage');
			arr.push('bitrates');
			return arr;
		}
	}
}
