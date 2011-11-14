package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.GetAllEntriesCommand;
	import com.kaltura.edw.control.commands.GetEntryRoughcutsCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class ContentTabController extends KMvCController {
		
		public function ContentTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(KedEntryEvent.GET_ENTRY_ROUGHCUTS, GetEntryRoughcutsCommand);
			addCommand(KedEntryEvent.GET_ALL_ENTRIES, GetAllEntriesCommand);
		}
	}
}