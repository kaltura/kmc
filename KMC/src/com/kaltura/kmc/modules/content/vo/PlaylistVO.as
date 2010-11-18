package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.kmc.modules.content.model.types.PlaylistTypes;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class PlaylistVO extends EntryVO
	{
		public function PlaylistVO() 
		{
			this.mediaType = PlaylistTypes.STATIC;
			parts.localPageSize = 100;
			parts.knownTotalPagesSize = true;
		}
		
		public var dynamicFilters : ArrayCollection = new ArrayCollection(); 
		public var imageDuration : Number = 2;
		public var playlistEntriesNum : Number = 50;
		
		public var playlistWidth : Number = 600;
		public var playlistHieght : Number = 300;
		
		public var embedText : String;
		
	}
}