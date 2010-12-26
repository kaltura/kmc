package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.vo.KalturaUser;

	public class EditUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var user:KalturaUser = (event as UserEvent).user;
			user.setUpdatedFieldsOnly(true);
			var uu:UserUpdate = new UserUpdate(_model.usersModel.selectedUser.id, user);
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
		}
	}
}