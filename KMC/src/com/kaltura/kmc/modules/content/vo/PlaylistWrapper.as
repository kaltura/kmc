package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.collections.ArrayCollection;
	
	public class PlaylistWrapper extends Object
	{
		
	[Bindable]
	public var playlist:KalturaPlaylist;
	[Bindable]
	public var parts:ArrayCollection;
	
		public function PlaylistWrapper(playlist:KalturaPlaylist= null,part:ArrayCollection = null) 
		{
			this.playlist=playlist;
			this.parts=part;
		}
	}
}