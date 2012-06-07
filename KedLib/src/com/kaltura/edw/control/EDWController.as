package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.kmvc.control.KMvCController;

	public class EDWController extends KMvCController {
		
		public function EDWController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(KedEntryEvent.DELETE_ENTRY, DeleteBaseEntryCommand);
			addCommand(KedEntryEvent.SET_SELECTED_ENTRY, SetSelectedEntryCommand);
			addCommand(KedEntryEvent.UPDATE_SINGLE_ENTRY, UpdateSingleEntry);
			addCommand(KedEntryEvent.LIST_ENTRIES_BY_REFID, ListEntriesByRefidCommand);
			
		}
	}
}