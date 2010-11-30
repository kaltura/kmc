package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleUpdate;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;

	public class EditRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var role:KalturaRole = (event as RoleEvent).role;
			var uu:RoleUpdate = new RoleUpdate(role.id.toString(), role);
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