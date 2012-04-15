package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SelectionEvent;
	
	public class SelectionCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case SelectionEvent.ENTRIES_SELECTION_CHANGED:
					_model.selectedEntries = (event as SelectionEvent).items;
					break;
				case SelectionEvent.CATEGORIES_SELECTION_CHANGED:
					_model.categoriesModel.selectedCategories = (event as SelectionEvent).items;
					break;
			}
		}

	}
}