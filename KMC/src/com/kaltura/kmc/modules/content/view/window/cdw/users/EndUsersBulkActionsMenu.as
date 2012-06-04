package com.kaltura.kmc.modules.content.view.window.cdw.users
{
	import com.kaltura.kmc.modules.content.events.CategoryUserEvent;
	import com.kaltura.kmc.modules.content.view.controls.bulkactions.BulkEntryActionsMenu;
	import com.kaltura.kmc.modules.content.view.controls.bulkactions.MenuItemVo;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	
	public class EndUsersBulkActionsMenu extends BulkEntryActionsMenu {
		
		/**
		 * users to which actions should apply 
		 */		
		public var users:Array;
		
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
			mi.data = "usersBulkApprove";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkDeactivate');
			mi.data = "usersBulkDeactivate";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkActivate');
			mi.data = "usersBulkActivate";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkPermLvl');
			mi.data = "usersBulkPermLvl";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkManual');
			mi.data = "usersBulkManual";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkAuto');
			mi.data = "usersBulkAuto";
			topLevel.children.push(mi);	
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'usersBulkDelete');
			mi.data = "usersBulkDelete";
			topLevel.children.push(mi);	
		}
		
		
		override protected function menu_itemClickHandler(event:MenuEvent):void {
			var cue:CategoryUserEvent;
			if (!users || users.length < 1) {
				Alert.show(resourceManager.getString('cms', 'usersBulkSelectUserFirst'), resourceManager.getString('cms', 'usersBulkSelectUserFirstTitle'));
				return;
			}
			switch (event.item.data) {
				case "usersBulkApprove":
				case "usersBulkActivate":
					cue = new CategoryUserEvent(CategoryUserEvent.ACTIVATE_CATEGORY_USER);
					cue.data = users;
					cue.dispatch();
					break;
				
				case "usersBulkDeactivate":
					cue = new CategoryUserEvent(CategoryUserEvent.DEACTIVATE_CATEGORY_USER);
					cue.data = users;
					cue.dispatch();
					break;
				
				case "usersBulkPermLvl":
					var permLvlWin:SetPermissionLevelWin = new SetPermissionLevelWin();
					permLvlWin.users = users;
					PopUpManager.addPopUp(permLvlWin, Application.application as DisplayObject, true);
					PopUpManager.centerPopUp(permLvlWin);
					break;
				
				case "usersBulkManual":
					cue = new CategoryUserEvent(CategoryUserEvent.SET_CATEGORY_USERS_MANUAL_UPDATE);
					cue.data = users;
					cue.dispatch();
					break;
				
				case "usersBulkAuto":
					cue = new CategoryUserEvent(CategoryUserEvent.SET_CATEGORY_USERS_AUTO_UPDATE);
					cue.data = users;
					cue.dispatch();
					break;
				
				case "usersBulkDelete":
					cue = new CategoryUserEvent(CategoryUserEvent.DELETE_CATEGORY_USERS);
					cue.data = users;
					cue.dispatch();
					break;
			}
		}
	}
}