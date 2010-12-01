package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleAdd;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleList;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
	import com.kaltura.net.KalturaCall;
	
	import mx.collections.ArrayCollection;

	public class AddRoleFromUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			var call:KalturaCall = new RoleAdd((event as RoleEvent).role);
			mr.addAction(call);
			//TODO + add filters to RoleList
			call = new RoleList();
			mr.addAction(call);
			_model.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				// change the flag to close the role drilldown
				_model.usersModel.roleDrilldownMode = DrilldownMode.NONE;
				// update the roles combobox dataprovider 
				_model.usersModel.allRoles = new ArrayCollection(data.data[1]);
				// trigger the setter to use the returned object as the role for current user
				_model.usersModel.newRole = data.data[0] as KalturaRole;
			}
		}
	}
}