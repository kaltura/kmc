package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.vo.KalturaUser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class UpdateUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var user:KalturaUser = (event as UserEvent).user;
			user.setUpdatedFieldsOnly(true);
			var userId:String = _model.usersModel.selectedUser.id;
			if (!userId) {
				// will happen if upgrading an end user via "add user"
				userId = user.id;
			}
			var uu:UserUpdate = new UserUpdate(userId, user);
			uu.addEventListener(KalturaEvent.COMPLETE, result);
			uu.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(uu);
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.drilldownMode = DrilldownMode.NONE;
			}
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('admin', 'after_user_edit')); 
		}
	}
}