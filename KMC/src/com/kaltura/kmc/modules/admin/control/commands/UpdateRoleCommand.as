package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.vo.KalturaUserRole;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	/**
	 * update a role after editing it. 
	 * @author Atar
	 * 
	 */	
	public class UpdateRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var role:KalturaUserRole = (event as RoleEvent).role;
			role.setUpdatedFieldsOnly(true);
			var uu:UserRoleUpdate = new UserRoleUpdate(role.id, role);
			uu.addEventListener(KalturaEvent.COMPLETE, result);
			uu.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(uu);
		}
		
		
		override protected function result(data:Object):void {
			super.result(data);
			if (data.success) {
				// no need to explicitly call list roles, as 
				// data is refreshed when the window closes. 
				_model.rolesModel.drilldownMode = DrilldownMode.NONE;
			}
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('admin', 'after_role_edit'));
		}
	}
}