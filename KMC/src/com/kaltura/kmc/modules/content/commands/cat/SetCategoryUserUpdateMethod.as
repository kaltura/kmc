package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryUser.CategoryUserUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.CategoryUserEvent;
	import com.kaltura.types.KalturaUpdateMethodType;
	import com.kaltura.vo.KalturaCategoryUser;
	
	public class SetCategoryUserUpdateMethod extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			// event.data is [KalturaCategoryUser]
			var usrs:Array = event.data;
			
			var mr:MultiRequest = new MultiRequest();
			var cu:KalturaCategoryUser;
			for (var i:int = 0; i<usrs.length; i++) {
				cu = usrs[i] as KalturaCategoryUser;
				if (event.type == CategoryUserEvent.SET_CATEGORY_USERS_AUTO_UPDATE) {
					cu.updateMethod = KalturaUpdateMethodType.AUTOMATIC;
				}
				else if (event.type == CategoryUserEvent.SET_CATEGORY_USERS_MANUAL_UPDATE){
					cu.updateMethod = KalturaUpdateMethodType.AUTOMATIC;
				}
				cu.setUpdatedFieldsOnly(true);
				mr.addAction(new CategoryUserUpdate(cu.categoryId, cu.userId, cu));
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