package com.kaltura.kmc.modules.studio.vo
{
	import com.kaltura.kmc.modules.studio.model.types.PlaylistTypes;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class PlaylistVO extends EntryVO
	{
		public var dynamicFilters : ArrayCollection = new ArrayCollection();
		public var imageDuration : Number = 2;
		public var playlistEntriesNum : Number = 50;
		public var playlistUrl : String = "";
		public var playlistWidth : Number = 600;
		public var playlistHieght : Number = 300;
		
		public var embedText : String;
		
		public function PlaylistVO() 
		{
			this.mediaType = PlaylistTypes.STATIC;
		}
		
		override public function clone() : EntryVO
		{
			var plst : PlaylistVO = new PlaylistVO();
			plst.playlistUrl = this.playlistUrl;
			plst.parts = this.parts;
			plst.entryId = this.entryId;
			plst.name = this.name;
			plst.thumbnailUrl = this.thumbnailUrl;
			plst.partnerId = this.partnerId;
			plst.subpId  = this.subpId;
			plst.puserId = this.puserId;
			plst.kshowId = this.kshowId;
			plst.tags = this.tags;
			plst.status = this.status;
			plst.type = this.type;
			plst.creator = this.creator;
			plst.playerLoads = this.playerLoads;
			plst.plays = this.plays; 
			plst.rank = this.rank;
			plst.createdAt = this.createdAt;
			plst.adminTags = this.adminTags;
			plst.flags = this.flags;
			plst.inVideoMix = this.inVideoMix;
			plst.moderationStatus = this.moderationStatus; 
			plst.version = this.version;
			plst.mediaType = this.mediaType;
			plst.dataPath = this.dataPath;
			plst.totalRank = this.totalRank;
			plst.duration = this.duration;
			plst.source = this.source;
			plst.sourceLink = this.sourceLink;
			plst.dataUrl = this.dataUrl;
			plst.description = this.description;
			plst.votesCount = this.votesCount;
			plst.selected = this.selected;
			plst.views = this.views;
			plst.dataContent = this.dataContent;
			plst.mediaType = this.mediaType;
			plst.dynamicFilters = this.dynamicFilters;
			plst.imageDuration = this.imageDuration;
			plst.playlistWidth = this.playlistWidth;
			plst.playlistHieght = this.playlistHieght;
			plst.embedText = this.embedText;
			
			return plst;
		}

	}
}