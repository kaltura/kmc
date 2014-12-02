package com.kaltura.kmc.modules.content.view.controls.bulkactions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.MenuEvent;
	
	
	public class BulkCategoryActionsMenu extends BulkEntryActionsMenu {
		
		[Bindable]
		/**
		 * RnP: show entitlements related actions
		 * */
		public var includeEntitlement:Boolean = true;
		
		[Bindable]
		/**
		 * RnP: show category users related actions
		 * */
		public var includeCategoryUserActions:Boolean = true;
		
		
		public function BulkCategoryActionsMenu() {
			BindingUtils.bindSetter(recreateMenu, this, "includeEntitlement");
		}
		
		private function recreateMenu(value:Boolean):void {
			// update value, then rebuild menu
			setTimeout(createMenu, 0);
		}
		
		override protected function createMenu():void {
			var mi:MenuItemVo;
			actions = [];
			
			var topLevel:MenuItemVo = new MenuItemVo();
			topLevel.label = resourceManager.getString('cms', 'bulkActions');
			topLevel.data = "bulk";
			topLevel.children = [];
			actions.push(topLevel);

			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'editTags');
			mi.children = [];
			topLevel.children.push(mi);
			
			var smi:MenuItemVo = new MenuItemVo();
			smi.label = resourceManager.getString('cms', 'addTags');
			smi.data = "addTags";
			mi.children.push(smi);
			
			smi = new MenuItemVo();
			smi.label = resourceManager.getString('cms', 'removeTags');
			smi.data = "removeTags";
			mi.children.push(smi);
			
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'bulkMoveCategories');
			mi.data = "moveCategories";
			topLevel.children.push(mi);
			
			
			if (includeCategoryUserActions) {
				if (includeEntitlement) {
					mi = new MenuItemVo();
					mi.label = resourceManager.getString('cms', 'bulkChangeCategoryAccess');
					mi.data = "changeAccess";
					topLevel.children.push(mi);
					
					mi = new MenuItemVo();
					mi.label = resourceManager.getString('cms', 'bulkChangeCategoryListing');
					mi.data = "changeListing";
					topLevel.children.push(mi);
					
					mi = new MenuItemVo();
					mi.label = resourceManager.getString('cms', 'bulkChangeCategoryPolicy');
					mi.data = "changeContribution";
					topLevel.children.push(mi);
				}
				
				mi = new MenuItemVo();
				mi.label = resourceManager.getString('cms', 'bulkChangeCategoryOwner');
				mi.data = "changeOwner";
				topLevel.children.push(mi);
			}
			
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
					break;
				
				case "changeContribution":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_CONTRIBUTION_WINDOW);
					break;
				
				case "changeAccess":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_ACCESS_WINDOW);
					break;
				
				case "changeListing":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_LISTING_WINDOW);
					break;
				
				case "changeOwner":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.CATEGORIES_OWNER_WINDOW);
					break;
				
				case "moveCategories":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.MOVE_CATEGORIES_WINDOW);
					break;
				
				case "addTags":
					cgEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.ADD_CATEGORY_TAGS_WINDOW);
					break;
				
				case "removeTags":
					cgEvent = new WindowEvent(WindowEvent.OPEN , WindowsStates.REMOVE_CATEGORY_TAGS_WINDOW);
					break;
			}
			if (cgEvent)
				cgEvent.dispatch();
		}
	}
}