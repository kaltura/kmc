package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryUser.CategoryUserUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategoryUser;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class SetCategoryUsersPermLevel extends KalturaCommand {
		
		private var _usrs:Array;
		private var _perm:int;
		
		override public function execute(event:CairngormEvent):void {
			// event.data is [desired perm lvl, [KalturaCategoryUser]]
			_perm = event.data[0];
			_usrs = event.data[1];
			
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
				cu.permissionLevel = _perm;
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