package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserAdd;
	import com.kaltura.kmc.modules.admin.control.UserEvent;
	import com.kaltura.kmc.modules.admin.model.UserDrilldownMode;

	public class AddUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var ua:UserAdd = new UserAdd((event as UserEvent).user);
			_model.kc.post(ua);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.drilldownMode = UserDrilldownMode.NONE;
			}
		}
	}
}