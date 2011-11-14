package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.ListEntriesCommand;
	import com.kaltura.edw.control.commands.LoadFilterDataCommand;
	import com.kaltura.edw.control.commands.customData.*;
	import com.kaltura.edw.control.events.LoadEvent;
	import com.kaltura.edw.control.events.MetadataDataEvent;
	import com.kaltura.edw.control.events.MetadataProfileEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class CustomDataTabController extends KMvCController {
		
		private static var _instance:CustomDataTabController;
		
		
		public static function getInstance():CustomDataTabController {
			if (!_instance){
				_instance = new CustomDataTabController();
			}
			return _instance;
		}
		
		public function CustomDataTabController()
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
			
		}
	}
}