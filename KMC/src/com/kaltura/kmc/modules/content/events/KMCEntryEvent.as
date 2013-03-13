package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class KMCEntryEvent extends CairngormEvent
	{
		
		public static const LIST_ENTRY_MODERATION : String = "content_listEntryModeration";
		
		public static const GET_FLAVOR_PARAMS : String = "content_getFlavorParams";
		
		/**
		 * execute playlist to see current entries
		 * */
		public static const GET_PLAYLIST : String = "content_getPlaylist";
		public static const ADD_PLAYLIST : String = "content_addPlaylist";
		public static const GET_PLAYLIST_STATS_FROM_CONTENT : String = "content_getPlaylistStatsFromcontent";
		
		/**
		 * dispatch this event to raise GetRuleBasedPlaylistCommand 
		 */		
		public static const GET_RULE_BASED_PLAYLIST : String = "content_getRuleBasedPlaylist";
		public static const RESET_RULE_BASED_DATA : String = "content_resetRuleBasedData";
		public static const PREVIEW : String = "content_preview";
		
		
		
		private var _entryVo : KalturaBaseEntry;
		private var _entryId : String;
		private var _entryIndex: int;
		private var _reloadEntry:Boolean;
		
		public function KMCEntryEvent(type:String, entryVo:KalturaBaseEntry, entryId:String = '', entryIIndex:int = -1, reloadEntry:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_entryVo = entryVo;
			_entryId = entryId;
			_entryIndex = entryIIndex;
			_reloadEntry = reloadEntry;
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
		
		public function get reloadEntry():Boolean {
			return _reloadEntry;
		}


	}
}