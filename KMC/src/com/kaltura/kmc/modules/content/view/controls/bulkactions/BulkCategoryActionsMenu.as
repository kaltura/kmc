package com.kaltura.kmc.modules.content.view.controls.bulkactions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	
	import flash.events.Event;
	
	import mx.events.MenuEvent;
	
	
	public class BulkCategoryActionsMenu extends BulkEntryActionsMenu {
		
		override protected function createMenu():void {
			var mi:MenuItemVo;
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
			mi.label = resourceManager.getString('cms', 'bulkChangeCategoryOwner');
			mi.data = "changeOwner";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'bulkMoveCategories');
			mi.data = "moveCategories";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
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
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_ACCESS_WINDOW);
					cgEvent.dispatch();
					break;
				
				case "changeListing":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_LISTING_WINDOW);
					cgEvent.dispatch();
					break;
				
				case "changeOwner":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_OWNER_WINDOW);
					cgEvent.dispatch();
					break;
				
				case "moveCategories":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.MOVE_CATEGORIES_WINDOW);
					cgEvent.dispatch();
					break;
			}
		}
	}
}