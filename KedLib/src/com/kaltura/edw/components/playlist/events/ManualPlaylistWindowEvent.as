package com.kaltura.edw.components.playlist.events
{
	import com.kaltura.edw.events.KedDataEvent;
	
	public class ManualPlaylistWindowEvent extends KedDataEvent {
		
		/**
		 * the value of the "type" attribute for the close event.
		 * dispatched when the window has to be closed by env.
		 * */
		public static const CLOSE:String = "closeWindow"; 
		
		/**
		 * defines the value of the type property for the refreshEntriesList event.
		 * */
		static public const REFRESH_ENTRIES_LIST:String = "refreshEntriesList";
		
		/**
		 * defines the value of the type property for the showEntryDetails event.
		 * dispatched when the drilldown to a certain entry is requested (so env can show it)
		 * event.data is the entry to drill into.
		 * */
		static public const SHOW_ENTRY_DETAILS:String = "showEntryDetails";
		
		/**
		 * defines the value of the type property for the saveNewPlaylist event.
		 * dispatched when a new playlist needs to be saved.
		 * event.data is the playlist to save. 
		 */		
		static public const SAVE_NEW_PLAYLIST:String = "saveNewPlaylist";

		/**
		 * defines the value of the type property for the saveExistingPlaylist event.
		 * dispatched when an existing playlist needs to be saved.
		 * event.data is the playlist to save. 
		 */		
		static public const SAVE_EXISTING_PLAYLIST:String = "saveExistingPlaylist";
		
		/**
		 * execute playlist and get its contents.
		 * ewvent.data is the required playlist
		 * */
		static public const GET_PLAYLIST:String = "getPlaylist";
		
		
		/**
		 * request the wrapper component to load filter 
		 * data and pass it into the window
		 * */
		static public const LOAD_FILTER_DATA:String = "loadFilterData";
		
		/**
		 * load entries according to the attached listableVo
		 * event.data is ListableVO
		 * */
		static public const SEARCH_ENTRIES:String = "searchEntries";
		
		
		
		public function ManualPlaylistWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}