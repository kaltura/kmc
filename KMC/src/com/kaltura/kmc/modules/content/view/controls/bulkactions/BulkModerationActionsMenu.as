package com.kaltura.kmc.modules.content.view.controls.bulkactions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	
	import flash.events.Event;
	
	import mx.events.MenuEvent;
	

	[Event(name="approveEntries", type="flash.events.Event")] 
	
	[Event(name="rejectEntries", type="flash.events.Event")]
	
	public class BulkModerationActionsMenu extends BulkEntryActionsMenu {
		
		
		override protected function createMenu():void {
			actions = [];
			
			var topLevel:MenuItemVo = new MenuItemVo();
			topLevel.label = resourceManager.getString('cms', 'bulkActions');
			topLevel.data = "bulk";
			topLevel.children = [];
			actions.push(topLevel);
			
			var mi:MenuItemVo = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'rejectSelected');
			mi.data = "reject";
			topLevel.children.push(mi);
			
			mi = new MenuItemVo();
			mi.label = resourceManager.getString('cms', 'approveSelected');
			mi.data = "approve";
			topLevel.children.push(mi);
			
			
		}
		
		
		override protected function menu_itemClickHandler(event:MenuEvent):void {
			var cgEvent:CairngormEvent;
			switch (event.item.data) {
				case "reject":
					dispatchEvent(new Event("rejectEntries"));
					break;
				
				case "approve":
					dispatchEvent(new Event("approveEntries"));
					break;
			}
		}
	}
}