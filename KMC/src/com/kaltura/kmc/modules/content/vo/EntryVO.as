package com.kaltura.kmc.modules.content.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.kmc.modules.content.model.types.MediaTypes;
	import com.kaltura.utils.pager.Pager;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class EntryVO implements IValueObject
	{
		public var moderations : ArrayCollection;
		public var parts : Pager = new Pager(); //roughcut ==> its parts , singleVideo ==> its roughcuts
		public var entryId : String = "";
		public var name : String= "";
		public var thumbnailUrl : String= "";
		public var partnerId : String = "";
		public var subpId : String = "";
		public var puserId : String = "";
		public var kshowId : String = "";
		public var tags : String = "";
		public var status : String = "";
		public var width : Number;
		public var height : Number;
		public var type : String = MediaTypes.VIDEO;
		public var creator : String = "";
		public var playerLoads : Number = 0;
		public var plays : Number = 0;
		public var rank : Number = 0;
		public var createAt : Date;
		public var createAtAsString : String;
		public var modifiedAt : Date;
		public var adminTags : String = "";
		public var flags : int = 0;
		public var inVideoMix : int = 0;
		public var moderationStatus : String = "";
		public var version : String = "";
		public var mediaType : String = "";
		public var dataPath : String = ""; 
		public var totalRank : String = "0";
		public var duration : Number = 0;
		public var source : String = "";
		public var sourceLink : String = "";
		public var dataUrl : String = "";
		public var description : String = "";
		public var votesCount : String = "0";
		public var views : String = "0";
		public var datacontent : String = null;
		public var selected : Boolean = false;
		
		
		public function clone() : EntryVO
		{
			var entry : EntryVO = new EntryVO();
			
			entry.parts = this.parts;
			entry.entryId = this.entryId;
			entry.name = this.name;
			entry.thumbnailUrl = this.thumbnailUrl;
			entry.partnerId = this.partnerId;
			entry.subpId  = this.subpId;
			entry.puserId = this.puserId;
			entry.kshowId = this.kshowId;
			entry.tags = this.tags;
			entry.width = this.width;
			entry.height = this.height;
			entry.status = this.status;
			entry.type = this.type;
			entry.creator = this.creator;
			entry.playerLoads = this.playerLoads;
			entry.plays = this.plays; 
			entry.rank = this.rank;
			entry.createAt = this.createAt;
			entry.adminTags = this.adminTags;
			entry.flags = this.flags;
			entry.inVideoMix = this.inVideoMix;
			entry.moderationStatus = this.moderationStatus; 
			entry.version = this.version;
			entry.mediaType = this.mediaType;
			entry.dataPath = this.dataPath;
			entry.totalRank = this.totalRank;
			entry.duration = this.duration;
			entry.source = this.source;
			entry.sourceLink = this.sourceLink;
			entry.dataUrl = this.dataUrl;
			entry.description = this.description;
			entry.votesCount = this.votesCount;
			entry.selected = this.selected;
			entry.views = this.views;
			entry.datacontent = this.datacontent;
			return entry;
		} 
		
		public function equal( entry : EntryVO ) : Boolean
		{
			if(!entry)
				return true;
				
			var isIt : Boolean = true;
			
			//if( entry.parts != this.parts ) isIt = false;  TODO: ASSUMTIONS!!
			if( entry.entryId != this.entryId ) isIt = false;
			if( entry.name != this.name ) isIt = false;
			if( entry.thumbnailUrl != this.thumbnailUrl ) isIt = false;
			if( entry.partnerId != this.partnerId ) isIt = false;
			if( entry.subpId  != this.subpId ) isIt = false;
			if( entry.puserId != this.puserId ) isIt = false;
			if( entry.kshowId != this.kshowId ) isIt= false;
			if( entry.tags != this.tags ) isIt = false;
			if( entry.status != this.status ) isIt = false;
			if( entry.type != this.type ) isIt = false;
			if( entry.creator != this.creator ) isIt = false;
			if( entry.playerLoads != this.playerLoads ) isIt = false;
			if( entry.plays != this.plays ) isIt = false;
			if( entry.rank != this.rank ) isIt = false;
			if( entry.width != this.width ) isIt = false;
			if( entry.height != this.height ) isIt = false;
			if( entry.createAt != this.createAt ) isIt = false;
			if( entry.adminTags != this.adminTags ) isIt = false;
			if( entry.flags != this.flags ) isIt = false;
			if( entry.inVideoMix != this.inVideoMix ) isIt = false;
			if( entry.moderationStatus != this.moderationStatus ) isIt = false; 
			if( entry.version != this.version ) isIt = false;
			if( entry.mediaType != this.mediaType ) isIt = false;
			if( entry.dataPath != this.dataPath ) isIt = false;
			if( entry.totalRank != this.totalRank ) isIt = false;
			if( entry.duration != this.duration ) isIt = false;
			if( entry.source != this.source ) isIt = false;
			if( entry.sourceLink != this.sourceLink ) isIt = false;
			if( entry.dataUrl != this.dataUrl ) isIt = false;
			if( entry.description != this.description ) isIt = false;
			if( entry.votesCount != this.votesCount ) isIt = false;
			if( entry.datacontent != this.datacontent ) isIt = false;
			
			return isIt;
		}
	}
}