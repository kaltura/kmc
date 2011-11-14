package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.DuplicateEntryDetailsModelCommand;
	import com.kaltura.edw.control.commands.GetSingleEntryCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.ModelEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class MetadataTabController extends KMvCController {
		
		public function MetadataTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(ModelEvent.DUPLICATE_ENTRY_DETAILS_MODEL, DuplicateEntryDetailsModelCommand);
			addCommand(KedEntryEvent.GET_ENTRY_AND_DRILLDOWN, GetSingleEntryCommand);
		}
	}
}