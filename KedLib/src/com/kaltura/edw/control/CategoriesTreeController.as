package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.categories.*;
	import com.kaltura.edw.control.events.CategoriesTreeEvent;
	import com.kaltura.kmvc.control.KMvCController;

	/**
	 * controller for categories tree
	 * @internal
	 * (not to be confused with KMC content's categories screen) 
	 * @author Atar
	 * 
	 */	
	public class CategoriesTreeController extends KMvCController {
		
		public function CategoriesTreeController() {
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(CategoriesTreeEvent.LIST_ALL_CATEGORIES, ListAllCategoriesCommand);
			addCommand(CategoriesTreeEvent.CREATE_ROOT_CATEGORY, CreateRootCatCommand);
			addCommand(CategoriesTreeEvent.LIST_CATEGORIES_UNDER, ListCategoriesUnderCommand);
			addCommand(CategoriesTreeEvent.FLUSH_CATEGORIES, FlushCategoriesDataCommand);
			addCommand(CategoriesTreeEvent.SET_CATEGORIES_DATA_MANAGER_TO_MODEL, SetCategoriesManagerCommand);
		}
		
		
		public function destroy():void {
			for each (var commandName:String in commands) {
				removeCommand(commandName);
			} 
		}
	}
}