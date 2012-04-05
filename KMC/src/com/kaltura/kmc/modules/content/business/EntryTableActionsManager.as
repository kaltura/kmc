package com.kaltura.kmc.modules.content.business
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.components.et.EntryTable;
	import com.kaltura.edw.components.et.events.EntryTableEvent;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;
	import com.kaltura.kmc.modules.content.events.SelectionEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaPlaylistType;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;
	import com.kaltura.vo.KalturaPlaylist;
	
	import mx.collections.ArrayCollection;

	/**
	 * handles EntryTable actions in a single location,
	 * so we won't have to duplicate code in all the classes that hold the ET.  
	 * @author atar.shadmi
	 */
	public class EntryTableActionsManager {
		
		/**
		 * delete selected entries
		 */
		public function deleteEntries(event:EntryTableEvent):void {
			var cgEvent:EntriesEvent = new EntriesEvent(EntriesEvent.DELETE_ENTRIES);
			cgEvent.dispatch();
		}
		
		
		/**
		 * open PnE window 
		 * @param event
		 */
		public function preview(event:EntryTableEvent):void {
			var entry:KalturaBaseEntry = event.data as KalturaBaseEntry;
			var cgEvent:KMCEntryEvent;
			if (entry is KalturaPlaylist)
				cgEvent = new KMCEntryEvent(KMCEntryEvent.PREVIEW, entry as KalturaPlaylist);
			else if (entry is KalturaMediaEntry || entry is KalturaMixEntry)
				cgEvent = new KMCEntryEvent(KMCEntryEvent.PREVIEW, entry as KalturaBaseEntry);
			else {
				trace("Error: no PlaylistVO nor EntryVO");
				return;
			}
			
			cgEvent.dispatch();
		}
		
		
		public function showEntryDetailsHandler(event:EntryTableEvent):void {
			var entry:KalturaBaseEntry = event.data as KalturaBaseEntry;
			var et:EntryTable = event.target as EntryTable;
			var kEvent:KMvCEvent = new KedEntryEvent(KedEntryEvent.SET_SELECTED_ENTRY, entry, entry.id, (et.dataProvider as ArrayCollection).getItemIndex(entry));
			KedController.getInstance().dispatch(kEvent);
			var cgEvent:CairngormEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.ENTRY_DETAILS_WINDOW);
			cgEvent.dispatch();
		}
		
		
		public function showPlaylistDetailsHandler(event:EntryTableEvent):void {
			var entry:KalturaBaseEntry = event.data as KalturaBaseEntry;
			var et:EntryTable = event.target as EntryTable;
			var cgEvent:CairngormEvent;
			var kEvent:KedEntryEvent = new KedEntryEvent(KedEntryEvent.SET_SELECTED_ENTRY, entry as KalturaBaseEntry, (entry as KalturaBaseEntry).id, (et.dataProvider as ArrayCollection).getItemIndex(entry));
			KedController.getInstance().dispatchEvent(kEvent);
			//switch manual / rule base
			if ((entry as KalturaPlaylist).playlistType == KalturaPlaylistType.STATIC_LIST) {
				// manual list
				cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.PLAYLIST_MANUAL_WINDOW);
				cgEvent.dispatch();
			}
			if ((entry as KalturaPlaylist).playlistType == KalturaPlaylistType.DYNAMIC) {
				cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.PLAYLIST_RULE_BASED_WINDOW);
				cgEvent.dispatch();
			}
		}
		
		
		public function itemClickHandler(event:EntryTableEvent):void {
			var et:EntryTable = event.target as EntryTable;
			var cgEvent:SelectionEvent = new SelectionEvent(SelectionEvent.SELECTION_CHANGED, et.selectedItems);
			cgEvent.dispatch();
		}
		
	}
}