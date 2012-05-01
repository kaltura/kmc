package com.kaltura.kmc.modules.content.view.window.cdw.users
{
	import com.kaltura.kmc.modules.content.view.controls.bulkactions.BulkEntryActionsMenu;
	import com.kaltura.kmc.modules.content.view.controls.bulkactions.MenuItemVo;
	
	import mx.events.MenuEvent;
	
	public class EndUsersBulkActionsMenu extends BulkEntryActionsMenu {
		
		override protected function createMenu():void {
			var mi:MenuItemVo;
			actions = [];
			
			var topLevel:MenuItemVo = new MenuItemVo();
			topLevel.label = resourceManager.getString('cms', 'bulkActions');
			topLevel.data = "bulk";
			topLevel.children = [];
			actions.push(topLevel);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkApprove');
			mi.data = "changeListing";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkPermLvl');
			mi.data = "changeAccess";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkManual');
			mi.data = "moveCategories";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkAuto');
			mi.data = "delete";
			topLevel.children.push(mi);	
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkDelete');
			mi.data = "delete";
			topLevel.children.push(mi);	
		}
		
		
		override protected function menu_itemClickHandler(event:MenuEvent):void {
//			var cgEvent:CairngormEvent;
//			switch (event.item.data) {
//				case "delete":
//					cgEvent = new CategoryEvent(CategoryEvent.DELETE_CATEGORIES);
//					cgEvent.dispatch();
//					break;
//				
//				case "changeAccess":
//					dispatchEvent(new Event("setCategoriesAccess"));
//					break;
//				
//				case "changeListing":
//					dispatchEvent(new Event("setCategoriesListing"));
//					break;
//				
//				case "moveCategories":
//					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.MOVE_CATEGORIES_WINDOW);
//					cgEvent.dispatch();
//					break;
//			}
		}
	}
}