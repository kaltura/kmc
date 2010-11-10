package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class EntryEvent extends CairngormEvent
	{
		public static const SET_SELECTED_ENTRY : String = "content_setSelectedEntry";
		public static const ADD_CHECKED_ENTRY : String = "content_addCheckedEntry";
		public static const REMOVE_CHECKED_ENTRY : String = "content_removeCheckedEntry";
		public static const LIST_ENTRY_MODERATION : String = "content_listEntryModeration";
		public static const GET_ALL_ENTRIES : String = "content_getAllEntries";
		public static const GET_ENTRY_ROUGHCUTS : String = "content_getEntryRoughcuts";
		public static const GET_PLAYLIST : String = "content_getPlaylist";
		public static const GET_FLAVOR_ASSETS : String = "content_getFlavorAssets";
		public static const GET_FLAVOR_PARAMS : String = "content_getFlavorParams";
		public static const ADD_PLAYLIST : String = "content_addPlaylist";
		public static const GET_PLAYLIST_STATS_FROM_CONTENT : String = "content_getPlaylistStatsFromcontent";
		public static const GET_RULE_BASED_PLAYLIST : String = "content_getRuleBasedPlaylist";
		public static const RESET_RULE_BASED_DATA : String = "content_resetRuleBasedData";
		public static const PREVIEW : String = "content_preview";
		
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