package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.userRole.UserRoleAdd;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaUserRole;
	
	import mx.collections.ArrayCollection;

	public class AddRoleFromUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			var call:KalturaCall = new UserRoleAdd((event as RoleEvent).role);
			mr.addAction(call);
			call = new UserRoleList(_model.rolesModel.rolesFilter);
			mr.addAction(call);
			_model.kc.post(mr);
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			if (data.success) {
				// change the flag to close the role drilldown
				_model.usersModel.roleDrilldownMode = DrilldownMode.NONE;
				// update the roles combobox dataprovider 
				_model.rolesModel.roles = new ArrayCollection(data.data[1]);
				// trigger the setter to use the returned object as the role for current user
				_model.usersModel.newRole = data.data[0] as KalturaUserRole;
			}
		}
	}
}