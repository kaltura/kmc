package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaMediaEntryFilterForPlaylist;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data that is used by the playlist windows 
	 * @author Atar
	 */	
	public class PlaylistModel {
		
		/**
		 * filter for rulebased playlists
		 * */
		public var onTheFlyFilter:KalturaMediaEntryFilterForPlaylist;
		
		/**
		 * number of entries in a rule-based playlist
		 * */
		public var ruleBasedEntriesAmount:Number;
		
		/**
		 * total playing time of a rule based playlist
		 * */
		public var ruleBasedDuration:String;
		
		/**
		 * RuleBasedTypeEvent.MULTY_RULES | RuleBasedTypeEvent.ONE_RULE 	<br>
		 * used when getting a rule-based playlist
		 * */
		public var rulePlaylistType:String;
		
		/**
		 * entries for creating a manual playlist
		 * read by <code>ManualPlaylistWindow</code>, when the 
		 * value is <code>_model.selectedEntries</code>
		 * */
		public var onTheFlyPlaylistEntries:ArrayCollection = null;
		
		/**
		 * AddPlaylistEvent.MANUAL_PLAYLIST | ''	<br>
		 * used in manual playlist window
		 * */
		public var onTheFlyPlaylistType:String;
	}
}