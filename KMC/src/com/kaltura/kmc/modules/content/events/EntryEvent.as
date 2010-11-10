package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class EntryEvent extends CairngormEvent
	{
		public static const SET_SELECTED_ENTRY : String = "setSelectedEntry";
		public static const ADD_CHECKED_ENTRY : String = "addCheckedEntry";
		public static const REMOVE_CHECKED_ENTRY : String = "removeCheckedEntry";
		public static const LIST_ENTRY_MODERATION : String = "listEntryModeration";
		public static const GET_ALL_ENTRIES : String = "getAllEntries";
		public static const GET_ENTRY_ROUGHCUTS : String = "getEntryRoughcuts";
		public static const GET_PLAYLIST : String = "getPlaylist";
		public static const GET_FLAVOR_ASSETS : String = "getFlavorAssets";
		public static const GET_FLAVOR_PARAMS : String = "getFlavorParams";
		public static const ADD_PLAYLIST : String = "addPlaylist";
		public static const GET_PLAYLIST_STATS_FROM_CONTENT : String = "getPlaylistStatsFromcontent";
		public static const GET_RULE_BASED_PLAYLIST : String = "getRuleBasedPlaylist";
		public static const RESET_RULE_BASED_DATA : String = "resetRuleBasedData";
		public static const PREVIEW : String = "preview";
		
		private var _entryVo : KalturaBaseEntry;
		
		public function EntryEvent(type:String, entryVo:KalturaBaseEntry, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_entryVo = entryVo;
		}

		public function get entryVo():KalturaBaseEntry
		{
			return _entryVo;
		}

	}
}