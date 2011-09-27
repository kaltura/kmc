package com.kaltura.edw.business
{
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlayableEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	public class Cloner
	{
		public function Cloner()
		{
		}
		
		/**
		 * clone according to entry type
		 * */
		public static function cloneByEntryType(entry:KalturaBaseEntry):KalturaBaseEntry {
			var copy:KalturaBaseEntry;
			
			if (entry is KalturaPlaylist) {
				copy = cloneKalturaPlaylist(entry as KalturaPlaylist);
			}
			else if (entry is KalturaMixEntry) {
				copy = cloneKalturaMixEntry(entry as KalturaMixEntry);
			}
			else if (entry is KalturaLiveStreamAdminEntry) {
				copy = cloneKalturaStreamAdminEntry(entry as KalturaLiveStreamAdminEntry);
			}
			else if (entry is KalturaMediaEntry) {
				copy = cloneKalturaMediaEntry(entry as KalturaMediaEntry);
			}
			return copy;
		}
		
		
		/**
		 * Return a new KalturaBaseEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaBaseEntry(source:KalturaBaseEntry):KalturaBaseEntry
		{
			var be:KalturaBaseEntry = new KalturaBaseEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				be[atts[i]] = source[atts[i]];
			} 
			
//			be.accessControlId = source.accessControlId;
//			be.startDate = source.startDate;
//			be.endDate = source.endDate;
//			be.id = source.id;
//			be.name = source.name;
//			be.description = source.description;
//			be.partnerId = source.partnerId;
//			be.userId = source.userId;
//			be.tags = source.tags;
//			be.adminTags = source.adminTags;
//			be.status = source.status;
//			be.moderationStatus = source.moderationStatus;
//			be.moderationCount = source.moderationCount;
//			be.type = source.type;
//			be.createdAt = source.createdAt;
//			be.rank = source.rank;
//			be.totalRank = source.totalRank;
//			be.votes = source.votes;
//			be.groupId = source.groupId;
//			be.partnerData = source.partnerData;
//			be.downloadUrl = source.downloadUrl;
//			be.searchText = source.searchText;
//			be.licenseType = source.licenseType;
//			be.version = source.version;
//			be.thumbnailUrl = source.thumbnailUrl;
//			be.categories = source.categories;
			return be;
		}
		
		/**
		 * Return a new KalturaPlayableEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaPlayableEntry(source:KalturaPlayableEntry):KalturaPlayableEntry
		{
			var kpe:KalturaPlayableEntry = new KalturaPlayableEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				kpe[atts[i]] = source[atts[i]];
			} 
			//base
//			kpe.accessControlId = source.accessControlId;
//			kpe.startDate = source.startDate;
//			kpe.endDate = source.endDate;
//			kpe.id = source.id;
//			kpe.name = source.name;
//			kpe.description = source.description;
//			kpe.partnerId = source.partnerId;
//			kpe.userId = source.userId;
//			kpe.tags = source.tags;
//			kpe.adminTags = source.adminTags;
//			kpe.status = source.status;
//			kpe.moderationStatus = source.moderationStatus;
//			kpe.moderationCount = source.moderationCount;
//			kpe.type = source.type;
//			kpe.createdAt = source.createdAt;
//			kpe.rank = source.rank;
//			kpe.totalRank = source.totalRank;
//			kpe.votes = source.votes;
//			kpe.groupId = source.groupId;
//			kpe.partnerData = source.partnerData;
//			kpe.downloadUrl = source.downloadUrl;
//			kpe.searchText = source.searchText;
//			kpe.licenseType = source.licenseType;
//			kpe.version = source.version;
//			kpe.thumbnailUrl = source.thumbnailUrl;
//			kpe.categories = source.categories;
//			// playable			
//			kpe.plays = source.plays;
//			kpe.views = source.views;
//			kpe.width = source.width;
//			kpe.height = source.height;
//			kpe.duration = source.duration;
//			kpe.msDuration = source.msDuration;
//			kpe.durationType = source.durationType;
			return kpe;
		}
		
		
		/**
		 * Return a new KalturaMediaEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaMediaEntry(source:KalturaMediaEntry):KalturaMediaEntry
		{
			var me:KalturaMediaEntry = new KalturaMediaEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				me[atts[i]] = source[atts[i]];
			} 
			//base entry
// 			me.accessControlId = source.accessControlId;
//			me.startDate = source.startDate;
//			me.endDate = source.endDate;
//			me.id = source.id;
//			me.name = source.name;
//			me.description = source.description;
//			me.partnerId = source.partnerId;
//			me.userId = source.userId;
//			me.tags = source.tags;
//			me.adminTags = source.adminTags;
//			me.status = source.status;
//			me.type = source.type;
//			me.createdAt = source.createdAt;
//			me.rank = source.rank;
//			me.totalRank = source.totalRank;
//			me.votes = source.votes;
//			me.groupId = source.groupId;
//			me.moderationStatus = source.moderationStatus;
//			me.moderationCount = source.moderationCount;
//			me.partnerData = source.partnerData;
//			me.downloadUrl = source.downloadUrl;
//			me.searchText = source.searchText;
//			me.licenseType = source.licenseType;
//			me.version = source.version;
//			me.thumbnailUrl = source.thumbnailUrl;
//			me.categories = source.categories; 
//			// playable entry
// 			me.plays = source.plays;
//			me.views = source.views;
//			me.width = source.width;
//			me.height = source.height;
//			me.duration = source.duration; 
//			me.msDuration = source.msDuration;
//			me.durationType = source.durationType;
//			// media entry
//			me.mediaType = source.mediaType;
//			me.conversionQuality = source.conversionQuality;
//			me.sourceType = source.sourceType;
//			me.searchProviderType = source.searchProviderType;
//			me.searchProviderId = source.searchProviderId;
//			me.creditUserName = source.creditUserName;
//			me.creditUrl = source.creditUrl;
//			me.mediaDate = source.mediaDate;
//			me.dataUrl = source.dataUrl;
//			me.flavorParamsIds = source.flavorParamsIds;
			
			
			return me;
		}

		/**
		 * Return a new KalturaPlaylist object with same attributes as source attributes
		 */
		public static function cloneKalturaPlaylist(source:KalturaPlaylist):KalturaPlaylist
		{
			var pl:KalturaPlaylist = new KalturaPlaylist();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				pl[atts[i]] = source[atts[i]];
			} 
			//clone base entries properties
//			pl.accessControlId = source.accessControlId;
//			pl.startDate = source.startDate;
//			pl.endDate = source.endDate;
//			pl.id = source.id;
//			pl.name = source.name;
//			pl.description = source.description;
//			pl.partnerId = source.partnerId;
//			pl.moderationStatus = source.moderationStatus;
//			pl.moderationCount = source.moderationCount;
//			pl.userId = source.userId;
//			pl.tags = source.tags;
//			pl.adminTags = source.adminTags;
//			pl.status = source.status;
//			pl.type = source.type;
//			pl.createdAt = source.createdAt;
//			pl.rank = source.rank;
//			pl.totalRank = source.totalRank;
//			pl.votes = source.votes;
//			pl.groupId = source.groupId;
//			pl.partnerData = source.partnerData;
//			pl.downloadUrl = source.downloadUrl;
//			pl.searchText = source.searchText;
//			pl.licenseType = source.licenseType;
//			pl.version = source.version;
//			pl.thumbnailUrl = source.thumbnailUrl;
//			pl.categories = source.categories;
//			//playlist properties
//			pl.playlistContent = source.playlistContent;
//			pl.playlistType = source.playlistType;
//			pl.views = source.views;
//			pl.plays = source.plays;
//			pl.duration = source.duration;
//			pl.totalResults = source.totalResults;
//			pl.filters = source.filters;
			
			return pl;
		}
		/**
		 * Return a new KalturaMixEntry object with same attributes as source attributes
		 */
		public static function cloneKalturaMixEntry(source:KalturaMixEntry):KalturaMixEntry
		{
			var mix:KalturaMixEntry = new KalturaMixEntry();
			
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				mix[atts[i]] = source[atts[i]];
			} 
			
			//clone base entries properties
//			mix.accessControlId = source.accessControlId;
//			mix.startDate = source.startDate;
//			mix.endDate = source.endDate;
//			mix.id = source.id;
//			mix.name = source.name;
//			mix.moderationStatus = source.moderationStatus;
//			mix.moderationCount = source.moderationCount;
//			mix.description = source.description;
//			mix.partnerId = source.partnerId;
//			mix.userId = source.userId;
//			mix.tags = source.tags;
//			mix.adminTags = source.adminTags;
//			mix.status = source.status;
//			mix.type = source.type;
//			mix.createdAt = source.createdAt;
//			mix.rank = source.rank;
//			mix.totalRank = source.totalRank;
//			mix.votes = source.votes;
//			mix.groupId = source.groupId;
//			mix.partnerData = source.partnerData;
//			mix.downloadUrl = source.downloadUrl;
//			mix.searchText = source.searchText;
//			mix.licenseType = source.licenseType;
//			mix.version = source.version;
//			mix.thumbnailUrl = source.thumbnailUrl;
//			mix.categories = source.categories;
//			//playable properties
//			mix.plays = source.plays;
//			mix.views = source.views;
//			mix.width = source.width;
//			mix.height = source.height;
//			mix.duration = source.duration;
//			mix.msDuration = source.msDuration;
//			mix.durationType = source.durationType;
//			//mix properties
//			mix.hasRealThumbnail = source.hasRealThumbnail;
//			mix.editorType = source.editorType;
//			mix.dataContent = source.dataContent;
			
			
			return mix;
		}
		
		public static function cloneKalturaStreamAdminEntry(source:KalturaLiveStreamAdminEntry):KalturaLiveStreamAdminEntry
		{
			var klsae:KalturaLiveStreamAdminEntry = new KalturaLiveStreamAdminEntry();
			var atts:Array = ObjectUtil.getObjectAllKeys(source);
			for (var i:int = 0; i< atts.length; i++) {
				klsae[atts[i]] = source[atts[i]];
			} 
			
			//kalturaStreamAdminEntry properties
//			klsae.encodingIP1 = source.encodingIP1; 
//			klsae.encodingIP2 = source.encodingIP2;
//			klsae.streamPassword = source.streamPassword;
//			klsae.streamUsername = source.streamUsername; 
//			//KalturaLiveStreamEntry properties
//			klsae.offlineMessage = source.offlineMessage; 
//			klsae.streamRemoteId = source.streamRemoteId;
//			klsae.streamRemoteBackupId = source.streamRemoteBackupId;
//			klsae.bitrates = source.bitrates;
//			//Kaltura Media Entry
//			klsae.accessControlId = source.accessControlId;
//			klsae.startDate = source.startDate;
//			klsae.endDate = source.endDate;
//			klsae.id = source.id;
//			klsae.name = source.name;
//			klsae.description = source.description;
//			klsae.partnerId = source.partnerId;
//			klsae.userId = source.userId;
//			klsae.tags = source.tags;
//			klsae.adminTags = source.adminTags;
//			klsae.status = source.status;
//			klsae.type = source.type;
//			klsae.createdAt = source.createdAt;
//			klsae.rank = source.rank;
//			klsae.totalRank = source.totalRank;
//			klsae.votes = source.votes;
//			klsae.groupId = source.groupId;
//			klsae.moderationStatus = source.moderationStatus;
//			klsae.moderationCount = source.moderationCount;
//			klsae.partnerData = source.partnerData;
//			klsae.downloadUrl = source.downloadUrl;
//			klsae.searchText = source.searchText;
//			klsae.licenseType = source.licenseType;
//			klsae.version = source.version;
//			klsae.thumbnailUrl = source.thumbnailUrl;
//			klsae.categories = source.categories; 
//			
//			// playable entry
//			klsae.plays = source.plays;
//			klsae.views = source.views;
//			klsae.width = source.width;
//			klsae.height = source.height;
//			klsae.duration = source.duration; 
//			
//			// media entry
//			klsae.mediaType = source.mediaType;
//			klsae.conversionQuality = source.conversionQuality;
//			klsae.sourceType = source.sourceType;
//			klsae.searchProviderType = source.searchProviderType;
//			klsae.searchProviderId = source.searchProviderId;
//			klsae.creditUserName = source.creditUserName;
//			klsae.creditUrl = source.creditUrl;
//			klsae.mediaDate = source.mediaDate;
//			klsae.dataUrl = source.dataUrl;
//			klsae.flavorParamsIds = source.flavorParamsIds;
			
			return klsae
		}
	}
}