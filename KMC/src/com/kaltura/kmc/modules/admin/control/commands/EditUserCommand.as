package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserUpdate;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.vo.KalturaUser;

	public class EditUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var user:KalturaUser = (event as UserEvent).user;
			var uu:UserUpdate = new UserUpdate(user.id, user);
			_model.kc.post(uu);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.drilldownMode = DrilldownMode.NONE;
			}
		}
	}
}