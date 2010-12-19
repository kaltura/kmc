package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaUserRole;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import mx.collections.ArrayCollection;

	public class DuplicateRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			//TODO + clone - get from server
			var call:KalturaCall;
//			call = new UserRoleClone((event as RoleEvent).role.id);
//			mr.addAction(call);
			// list
			call = new UserRoleList(_model.rolesModel.filter);
			mr.addAction(call);
			// post
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			// select the new role
			_model.rolesModel.selectedRole = data.data[0] as KalturaUserRole;
			// open drilldown for returned KalturaRole
			_model.rolesModel.newRole = data.data[0] as KalturaUserRole;
			_model.rolesModel.newRole = null;
			
			var response:KalturaUserRoleListResponse = data.data[1] as KalturaUserRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
		} 
	}
}