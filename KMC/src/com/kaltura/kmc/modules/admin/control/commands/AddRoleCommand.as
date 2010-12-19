package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleAdd;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;

	public class AddRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var ua:UserRoleAdd = new UserRoleAdd((event as RoleEvent).role);
			_model.kc.post(ua);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.rolesModel.drilldownMode = DrilldownMode.NONE;
			}
		}
	}
}