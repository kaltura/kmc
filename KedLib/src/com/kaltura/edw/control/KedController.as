package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.*;
	import com.kaltura.edw.control.events.*;
	import com.kaltura.kmvc.control.KMvCController;
	
	/**
	 * Controller which is accessible from all elements, so that KMC
	 * can use KED commands. 
	 * @author Atar
	 */	
	public class KedController extends KMvCController {
		
		private static var _instance:KedController;
		
		public static function getInstance():KedController {
			if (!_instance) {
				_instance = new KedController(new Enforcer());
			}
			return _instance;
		}
		
		public function KedController(enf:Enforcer) {
			
			initializeCommands();
		}
		
		
		public function initializeCommands():void {
			addCommand(LoadEvent.LOAD_FILTER_DATA, LoadFilterDataCommand);
			addCommand(KedEntryEvent.SET_SELECTED_ENTRY, SetSelectedEntryCommand);
			addCommand(KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, GetSingleEntryCommand);
			addCommand(KedEntryEvent.GET_ENTRY_AND_DRILLDOWN, GetSingleEntryCommand);
			addCommand(KedEntryEvent.GET_ENTRY_OWNER, GetEntryOwnerCommand);
			addCommand(SearchEvent.SEARCH_ENTRIES, ListEntriesCommand);
		}
	}
}
class Enforcer{}