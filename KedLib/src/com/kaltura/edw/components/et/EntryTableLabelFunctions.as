package com.kaltura.edw.components.et
{
	import com.kaltura.types.KalturaEntryModerationStatus;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaPlaylistType;
	import com.kaltura.utils.KTimeUtil;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaClipAttributes;
	import com.kaltura.vo.KalturaLiveEntry;
	import com.kaltura.vo.KalturaLiveStreamEntry;
	import com.kaltura.vo.KalturaOperationAttributes;
	
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class EntryTableLabelFunctions {
		
		
		public static function formatDate(item:Object, column:DataGridColumn):String {
			var df:DateFormatter = new DateFormatter();
			df.formatString = ResourceManager.getInstance().getString('cms', 'listdateformat');
			var dt:Date = new Date();
			dt.setTime(item.createdAt * 1000);
			return df.format(dt);
		};

		public static function getPlaylistMediaTypes(item:Object, column:DataGridColumn):String {
			switch (item.playlistType) {
				case KalturaPlaylistType.STATIC_LIST:
					return ResourceManager.getInstance().getString('cms', 'manuall');
					break;
				case KalturaPlaylistType.DYNAMIC:
					return ResourceManager.getInstance().getString('cms', 'ruleBased');
					break;
				case KalturaPlaylistType.EXTERNAL:
					return ResourceManager.getInstance().getString('cms', 'externalRss');
					break;
			}
			return "";
		}
		
		public static function getClipIntime(item:Object, column:DataGridColumn):String {
			var entry:KalturaBaseEntry = item as KalturaBaseEntry;
			var result:String = '';
			for each (var opatt:KalturaOperationAttributes in entry.operationAttributes) {
				if (opatt is KalturaClipAttributes) {
					result = formatTime((opatt as KalturaClipAttributes).offset);
					break;
				}
			}
			return result;
		}
		
		
		private static function formatTime(offset:Number):String {
			var df:DateFormatter = new DateFormatter();
			df.formatString = ResourceManager.getInstance().getString('drilldown', 'h_m_s_ms');
			var dt:Date = new Date();
			dt.hours = dt.minutes = dt.seconds = 0;
			dt.milliseconds = offset;
			return df.format(dt);
		}
		
		
		/**
		 * format the timer
		 */
		public static function getTimeFormat(item:Object, column:DataGridColumn):String {
			if (item is KalturaLiveEntry) {
				return ResourceManager.getInstance().getString('cms', 'n_a');
			}
			return KTimeUtil.formatTime2(item.duration, true, true);
		}
		
		
		/**
		 * get correct string for entry moderation status 
		 */		
		public static function getStatusForModeration(item:Object, column:DataGridColumn):String {
			var entry:KalturaBaseEntry = item as KalturaBaseEntry;
			var rm:IResourceManager = ResourceManager.getInstance();
			switch (entry.moderationStatus) {
				case KalturaEntryModerationStatus.APPROVED:  {
					return rm.getString('entrytable', 'approvedStatus');
				}
				case KalturaEntryModerationStatus.AUTO_APPROVED:  {
					return rm.getString('entrytable', 'autoApprovedStatus');
				}
				case KalturaEntryModerationStatus.FLAGGED_FOR_REVIEW:  {
					return rm.getString('entrytable', 'flaggedStatus');
				}
				case KalturaEntryModerationStatus.PENDING_MODERATION:  {
					return rm.getString('entrytable', 'pendingStatus');
				}
				case KalturaEntryModerationStatus.REJECTED:  {
					return rm.getString('entrytable', 'rejectedStatus');
				}
			}
			return '';
		}

		/**
		 * the function translate status type enum to the matching locale string
		 * @param obj	data object for the itemrenderer
		 */
		public static function getStatus(item:Object, column:DataGridColumn):String {
			var rm:IResourceManager = ResourceManager.getInstance();
			var entry:KalturaBaseEntry = item as KalturaBaseEntry;
			var status:String = entry.status;
			switch (status) {
				case KalturaEntryStatus.DELETED: 
					//fixed to all states
					return rm.getString('cms', 'statusdeleted');
					break;
				
				case KalturaEntryStatus.ERROR_IMPORTING: 
					//fixed to all states
					return rm.getString('cms', 'statuserrorimporting');
					break;
				
				case KalturaEntryStatus.ERROR_CONVERTING: 
					//fixed to all states
					return rm.getString('cms', 'statuserrorconverting');
					break;
				
				case KalturaEntryStatus.IMPORT: 
					//fixed to all states
					if (entry is KalturaLiveStreamEntry) {
						return rm.getString('cms', 'provisioning');
					}
					else {
						return rm.getString('cms', 'statusimport');
					}
					break;
				
				case KalturaEntryStatus.PRECONVERT: 
					//fixed to all states
					return rm.getString('cms', 'statuspreconvert');
					break;
				
				case KalturaEntryStatus.PENDING:
					return rm.getString('cms', 'statuspending');
					break;
				
				case KalturaEntryStatus.NO_CONTENT:  
					return rm.getString('cms', 'statusNoMedia');
					break;
				
				case KalturaEntryStatus.READY:  
					return getStatusForReadyEntry(entry);
					break;
				
			}
			return '';
		}
		
		
		private static const SCHEDULING_ALL_OR_IN_FRAME:int = 1;
		private static const SCHEDULING_BEFORE_FRAME:int = 2;
		private static const SCHEDULING_AFTER_FRAME:int = 3;
		
		/**
		 * the text for a ready entry is caculated according to moderation status / scheduling
		 * */
		private static function getStatusForReadyEntry(entry:KalturaBaseEntry):String {
			var rm:IResourceManager = ResourceManager.getInstance();
			var result:String = '';
			var now:Date = new Date();
			var time:int = now.time / 1000;
			var schedulingType:int = 0;
			
			if (((entry.startDate == int.MIN_VALUE) && (entry.endDate == int.MIN_VALUE)) || ((entry.startDate <= time) && (entry.endDate >= time)) || ((entry.startDate < time) && (entry.endDate == int.MIN_VALUE)) || ((entry.startDate == int.MIN_VALUE) && (entry.endDate > time))) {
				schedulingType = SCHEDULING_ALL_OR_IN_FRAME;
			}
			else if (entry.startDate > time) {
				schedulingType = SCHEDULING_BEFORE_FRAME;
			}
			else if (entry.endDate < time) {
				schedulingType = SCHEDULING_AFTER_FRAME;
			}
			
			var moderationStatus:int = entry.moderationStatus;
			
			
			switch (moderationStatus) {
				case KalturaEntryModerationStatus.APPROVED:
				case KalturaEntryModerationStatus.AUTO_APPROVED:
				case KalturaEntryModerationStatus.FLAGGED_FOR_REVIEW:  
					if (schedulingType == SCHEDULING_ALL_OR_IN_FRAME){
						result = rm.getString('entrytable', 'liveStatus');
					}
					else if (schedulingType == SCHEDULING_BEFORE_FRAME) {
						result = rm.getString('entrytable', 'scheduledStatus');
					}
					else if (schedulingType == SCHEDULING_AFTER_FRAME) {
						result = rm.getString('entrytable', 'finishedStatus');
					}
					break;
				
				case KalturaEntryModerationStatus.PENDING_MODERATION:  
					result = rm.getString('entrytable', 'pendingStatus');
					break;
				
				case KalturaEntryModerationStatus.REJECTED:  
					result = rm.getString('entrytable', 'rejectedStatus');
					break;
				
			}
			
			
			return result;
		}
	}
}