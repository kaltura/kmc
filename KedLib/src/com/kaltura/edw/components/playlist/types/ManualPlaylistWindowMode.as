package com.kaltura.edw.components.playlist.types
{
	/**
	 * defines the values of the "context" attribute of 
	 * <code>ManualPlaylistWindow</code> according to its different modes. 
	 * @author Atar
	 * 
	 */	
	public class ManualPlaylistWindowMode {
		
		/**
		 * defines the value of <code>context</code> when window is in edit linked entries mode.
		 * */
		static public const EDIT_LINKED_ENTRIES_MODE:String = "editLinkedEntriesMode";
		
		/**
		 * defines the value of <code>context</code> when window is in edit playlist mode.
		 * */
		static public const EDIT_PLAYLIST_MODE:String = "editPlaylistMode";
		
		/**
		 * defines the value of <code>context</code> when window is in new playlist mode.
		 * */
		static public const NEW_PLAYLIST:String = "newPlaylist";
		
		/**
		 * defines the value of <code>context</code> when window is in new linked entries mode.
		 * */
		static public const NEW_LINKED_ENTRIES:String = "newLinkedEntries";
	}
}