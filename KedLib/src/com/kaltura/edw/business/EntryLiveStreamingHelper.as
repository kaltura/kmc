package com.kaltura.edw.business
{
	import com.kaltura.types.KalturaDVRStatus;
	import com.kaltura.types.KalturaRecordStatus;
	import com.kaltura.utils.KTimeUtil;
	import com.kaltura.vo.KalturaLiveStreamEntry;
	
	import mx.resources.ResourceManager;

	public class EntryLiveStreamingHelper
	{
		
		public static const PREFIXES_WIDTH:Number = 130;
		public static const BROADCASTING_WIDTH:Number = 500;
		
		public function EntryLiveStreamingHelper()
		{
		}
		
		public static function getDVRStatus (entry:KalturaLiveStreamEntry):String {
			var result:String = '';
			if (!entry.dvrStatus || entry.dvrStatus == KalturaDVRStatus.DISABLED) {
				result = ResourceManager.getInstance().getString('drilldown', 'off');
			}
			else if (entry.dvrStatus == KalturaDVRStatus.ENABLED) {
				result = ResourceManager.getInstance().getString('drilldown', 'on');
			}
			return result;
		}
		
		public static function getDVRWindow (entry:KalturaLiveStreamEntry):String {
			return ResourceManager.getInstance().getString('drilldown', 'dvrWinFormat', [KTimeUtil.formatTime2(entry.dvrWindow*60, true, false, true)]);
		}
		
		public static function getRecordStatus (entry:KalturaLiveStreamEntry):String {
			var result:String = '';
			if (!entry.recordStatus || entry.recordStatus == KalturaRecordStatus.DISABLED) {
				result = ResourceManager.getInstance().getString('drilldown', 'off');
			}
			else if (entry.recordStatus == KalturaRecordStatus.APPENDED || entry.recordStatus == KalturaRecordStatus.PER_SESSION) {
				result = ResourceManager.getInstance().getString('drilldown', 'on');
			}
			return result;
		}
		
		
	}
}