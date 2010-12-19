package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleUpdate;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;

	public class EditRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var role:KalturaRole = (event as RoleEvent).role;
			var uu:UserRoleUpdate = new UserRoleUpdate(role.id.toString(), role);
			_model.kc.post(uu);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.rolesModel.drilldownMode = DrilldownMode.NONE;
			}
		}
	}
}