package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;

	public class AddRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var ua:UserRoleAdd = new UserRoleAdd((event as RoleEvent).role);
			ua.addEventListener(KalturaEvent.COMPLETE, result);
			ua.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(ua);
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.rolesModel.drilldownMode = DrilldownMode.NONE;
			}
			_model.decreaseLoadCounter();
		}
	}
}