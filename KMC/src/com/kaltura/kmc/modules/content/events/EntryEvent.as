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
		public static const GET_FLAVOR_ASSETS_FOR_PREVIEW : String = "content_getFlavorAssetsForPreview";
		public static const ADD_PLAYLIST : String = "content_addPlaylist";
		public static const GET_PLAYLIST_STATS_FROM_CONTENT : String = "content_getPlaylistStatsFromcontent";
		
		/**
		 * dispatch this event to raise GetRuleBasedPlaylistCommand 
		 */		
		public static const GET_RULE_BASED_PLAYLIST : String = "content_getRuleBasedPlaylist";
		public static const RESET_RULE_BASED_DATA : String = "content_resetRuleBasedData";
		public static const PREVIEW : String = "content_preview";
		public static const GET_ENTRY : String = "content_get_entry";
		public static const DELETE_ENTRY : String = "content_delete_entry";
		public static const GET_REPLACEMENT_ENTRY : String = "content_get_replacement_entry";
		public static const GET_SELECTED_ENTRY : String = "content_get_selected_entry";
		
		/**
		 * triggers a baseEntry.update with the given baseEntry, with no side effects.
		 * */
		public static const UPDATE_SINGLE_ENTRY:String = "content_update_single_entry";
		
		/**
		 * get a list of entries with the same reference id as the given
		 * */
		public static const LIST_ENTRIES_BY_REFID:String = "content_list_entries_by_refid"; 
		
		
		
		
		private var _entryVo : KalturaBaseEntry;
		private var _entryId : String;
		private var _entryIndex: int;
		
		public function EntryEvent(type:String, entryVo:KalturaBaseEntry, entryId:String = '', entryIIndex:int = -1,  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_entryVo = entryVo;
			_entryId = entryId;
			_entryIndex = entryIIndex;
		}

		public function get entryVo():KalturaBaseEntry
		{
			return _entryVo;
		}

		public function get entryId():String
		{
			return _entryId;
		}
		
		public function get entryIndex():int 
		{
			return _entryIndex;
		}


	}
}