package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.DuplicateEntryDetailsModelCommand;
	import com.kaltura.edw.control.commands.GetEntryCategoriesCommand;
	import com.kaltura.edw.control.commands.GetSingleEntryCommand;
	import com.kaltura.edw.control.commands.ListEntriesCommand;
	import com.kaltura.edw.control.commands.LoadFilterDataCommand;
	import com.kaltura.edw.control.commands.UpdateEntryCategoriesCommand;
	import com.kaltura.edw.control.commands.customData.*;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.LoadEvent;
	import com.kaltura.edw.control.events.MetadataDataEvent;
	import com.kaltura.edw.control.events.MetadataProfileEvent;
	import com.kaltura.edw.control.events.ModelEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class DataTabController extends KMvCController {
		
		private static var _instance:DataTabController;
		
		
		public static function getInstance():DataTabController {
			if (!_instance){
				_instance = new DataTabController();
			}
			return _instance;
		}
		
		public function DataTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(MetadataProfileEvent.GET_METADATA_UICONF, GetMetadataUIConfCommand);
			addCommand(MetadataProfileEvent.LIST, ListMetadataProfileCommand);
			addCommand(MetadataProfileEvent.GET, GetMetadataProfileCommand);
			addCommand(MetadataDataEvent.LIST, ListMetadataDataCommand);
			addCommand(SearchEvent.SEARCH_ENTRIES, ListEntriesCommand);
			addCommand(LoadEvent.LOAD_FILTER_DATA, LoadFilterDataCommand);
			
			addCommand(ModelEvent.DUPLICATE_ENTRY_DETAILS_MODEL, DuplicateEntryDetailsModelCommand);
			addCommand(KedEntryEvent.GET_ENTRY_AND_DRILLDOWN, GetSingleEntryCommand);	
			addCommand(KedEntryEvent.GET_ENTRY_CATEGORIES, GetEntryCategoriesCommand);	
			addCommand(KedEntryEvent.RESET_ENTRY_CATEGORIES, GetEntryCategoriesCommand);	
			addCommand(KedEntryEvent.UPDATE_ENTRY_CATEGORIES, UpdateEntryCategoriesCommand);	
		}
	}
}