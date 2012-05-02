package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryUser.CategoryUserActivate;
	import com.kaltura.commands.categoryUser.CategoryUserDeactivate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.CategoryUserEvent;
	import com.kaltura.vo.KalturaCategoryUser;
	
	public class ToggleCategoryUserStatusCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			// event.data is [KalturaCategoryUser]
			var usrs:Array = event.data;
			
			var mr:MultiRequest = new MultiRequest();
			var cu:KalturaCategoryUser;
			for (var i:int = 0; i<usrs.length; i++) {
				cu = usrs[i] as KalturaCategoryUser;
				if (event.type == CategoryUserEvent.DEACTIVATE_CATEGORY_USER) {
					mr.addAction(new CategoryUserDeactivate(cu.categoryId, cu.userId));
				}
				else {
					mr.addAction(new CategoryUserActivate(cu.categoryId, cu.userId));
				}
			} 			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);	   
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var cg:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORY_USERS);
			cg.dispatch();
			_model.decreaseLoadCounter();
		}
	}
}