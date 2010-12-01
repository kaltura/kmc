package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;

	public class SelectRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.rolesModel.selectedRole = (event as RoleEvent).role;
		} 
	}
}