package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;

	/**
	 * this class represents an event concerning a group of entries 
	 */	
	public class EntriesEvent extends CairngormEvent {
		public static const SET_SELECTED_ENTRIES:String = "setSelectedEntries";
		public static const SET_SELECTED_ENTRIES_FOR_PLAYLIST:String = "setSelectedEntriesForPlaylist";
		public static const UPDATE_ENTRIES:String = "updateEntries";
		public static const UPDATE_PLAYLISTS:String = "updatePlaylists";
		public static const DELETE_ENTRIES:String = "deleteEntries";
		
		/**
		 * entries relevant for this event.
		 * each entry is <code>KalturaBaseEntry</code> 
		 */
		private var _entries:ArrayCollection;


		/**
		 * Constructor. 
		 * @param type		event type
		 * @param entries	entries this event effects
		 * @param bubbles	should the event bubble
		 * @param cancelable	should the event be cancelable
		 * 
		 */		
		public function EntriesEvent(type:String, entries:ArrayCollection = null, bubbles:Boolean = false,
									 cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._entries = entries;
		}

		public function get entries():ArrayCollection
		{
			return _entries;
		}
	}
}