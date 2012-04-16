package com.kaltura.kmc.modules.content.view.controls.bulkactions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	
	import flash.events.Event;
	
	import mx.events.MenuEvent;
	
	[Event(name="setCategoriesAccess", type="flash.events.Event")]
	[Event(name="setCategoriesListing", type="flash.events.Event")]
	
	public class BulkCategoryActionsMenu extends BulkEntryActionsMenu {
		
		override protected function createMenu():void {
			actions = [];
			
			var topLevel:MenuItemVo = new MenuItemVo();
			topLevel.label = resourceManager.getString('cms', 'bulkActions');
			topLevel.data = "bulk";
			topLevel.children = [];
			actions.push(topLevel);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'bulkChangeCategoryListing');
			mi.data = "changeListing";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'bulkChangeCategoryAccess');
			mi.data = "changeAccess";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'bulkMoveCategories');
			mi.data = "moveCategories";
			topLevel.children.push(mi);
			
			var mi:MenuItemVo = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'deleteCategoryAction');
			mi.data = "delete";
			topLevel.children.push(mi);	
		}
		
		
		override protected function menu_itemClickHandler(event:MenuEvent):void {
			var cgEvent:CairngormEvent;
			switch (event.item.data) {
				case "delete":
					cgEvent = new CategoryEvent(CategoryEvent.DELETE_CATEGORIES);
					cgEvent.dispatch();
					break;
				
				case "changeAccess":
					dispatchEvent(new Event("setCategoriesAccess"));
					break;
				
				case "changeListing":
					dispatchEvent(new Event("setCategoriesListing"));
					break;
				
				case "moveCategories":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.MOVE_CATEGORIES_WINDOW);
					cgEvent.dispatch();
					break;
			}
		}
	}
}