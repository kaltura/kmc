package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	
	public class KedEntryEvent extends KMvCEvent {
		
		// ======================================================
		// Event Names
		// ======================================================
		
		/**
		 * triggers a baseEntry.update with the given baseEntry, with no side effects.
		 * event.data {entry:_undoToEntry, closeAfterSave:_closeAfterSave, nextEntryPending:_nextEntryPending}
		 * */
		public static const UPDATE_SINGLE_ENTRY:String = "ked_update_single_entry";
		
		public static const DELETE_ENTRY : String = "content_delete_entry";
		
		/**
		 * get a list of entries with the same reference id as the given
		 * */
		public static const LIST_ENTRIES_BY_REFID:String = "content_list_entries_by_refid"; 
		
		/**
		 * set the given entry as selected entry on the current entryDetailsModel 
		 */
		public static const SET_SELECTED_ENTRY : String = "content_setSelectedEntry";
		
		public static const GET_FLAVOR_ASSETS : String = "content_getFlavorAssets";
		
		
		/**
		 * after getting the entry, open the drilldown with its details.
		 * this event changes the selected entry on the entryDetailsModel
		 */
		public static const GET_ENTRY_AND_DRILLDOWN : String = "content_get_entry_and_drilldown";
		
		public static const GET_REPLACEMENT_ENTRY : String = "content_get_replacement_entry";
		
		/**
		 * get the selected entry and update only replacement status related fields
		 * */
		public static const UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS : String = "content_update_selected_entry_replacement_status";
		
		/**
		 * get mixes that have the current entry 
		 */
		public static const GET_ALL_ENTRIES : String = "content_getAllEntries";
		
		/**
		 * get entries that participate in the current mix 
		 */
		public static const GET_ENTRY_ROUGHCUTS : String = "content_getEntryRoughcuts";

		/**
		 * reset entry parts list on the model
		 */
		public static const RESET_PARTS : String = "content_resetParts";
		
		// ======================================================
		// Private Members
		// ======================================================
		
		private var _entryVo : KalturaBaseEntry;
		private var _entryId : String;
		private var _entryIndex: int;
		private var _reloadEntry:Boolean;
		
		// ======================================================
		// Constructor
		// ======================================================
		public function KedEntryEvent(type:String, entryVo:KalturaBaseEntry, entryId:String = '', entryIIndex:int = -1, reloadEntry:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_entryVo = entryVo;
			_entryId = entryId;
			_entryIndex = entryIIndex;
			_reloadEntry = reloadEntry;
		}
		
		// ======================================================
		// Getters
		// ======================================================
		
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