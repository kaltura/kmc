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
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class SetCategoryUserUpdateMethod extends KalturaCommand {
		
		private var _usrs:Array;
		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void {
			// event.data is [KalturaCategoryUser]
			_usrs = event.data;
			_eventType = event.type;
			
			if (!_model.categoriesModel.categoryUserFirstAction) {
				var rm:IResourceManager = ResourceManager.getInstance();
				Alert.show(rm.getString('cms', 'catUserFirstAction'), rm.getString('cms', 'catUserFirstActionTitle'), Alert.OK|Alert.CANCEL, null, afterConfirm);
				_model.categoriesModel.categoryUserFirstAction = true;
			}
			else {
				afterConfirm();
			}
		}
		
		private function afterConfirm(event:CloseEvent = null):void {
			if (event && event.detail == Alert.CANCEL) {
				return;
			}
			_model.increaseLoadCounter();
			
			
			var mr:MultiRequest = new MultiRequest();
			var cu:KalturaCategoryUser;
			for (var i:int = 0; i<_usrs.length; i++) {
				cu = _usrs[i] as KalturaCategoryUser;
				if (_eventType == CategoryUserEvent.SET_CATEGORY_USERS_AUTO_UPDATE) {
					cu.updateMethod = KalturaUpdateMethodType.AUTOMATIC;
				}
				else if (_eventType == CategoryUserEvent.SET_CATEGORY_USERS_MANUAL_UPDATE){
					cu.updateMethod = KalturaUpdateMethodType.MANUAL;
				}
				cu.setUpdatedFieldsOnly(true);
				mr.addAction(new CategoryUserUpdate(cu.categoryId, cu.userId, cu, true));
			} 			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);	   
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (!checkError(data)) {
				var cg:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORY_USERS);
				cg.dispatch();
			}
			_model.decreaseLoadCounter();
		}
	}
}