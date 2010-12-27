package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.userRole.UserRoleClone;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.commands.userRole.UserRoleUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaUserRole;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	public class DuplicateRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			var call:KalturaCall;
			var role:KalturaUserRole = (event as RoleEvent).role; 
			// pass result of first call to second call
			mr.addRequestParam("2:userRoleId", "{1:result:id}");
			mr.addRequestParam("2:userRole:name", ResourceManager.getInstance().getString('admin', 'duplicate_name') + ' ' + role.name);
			// duplicate the role
			call = new UserRoleClone(role.id);
			mr.addAction(call);
			// edit new role's name (both params are dummy, real value is taken from the first call
			call = new UserRoleUpdate(int.MIN_VALUE, new KalturaUserRole());
			mr.addAction(call);
			
			// list
			call = new UserRoleList(_model.rolesModel.rolesFilter);
			mr.addAction(call);
			// post
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.kc.post(mr);
		}
		
		override protected function result(data:Object):void {
			super.result(data);
			// select the new role
			_model.rolesModel.selectedRole = data.data[1] as KalturaUserRole;
			// open drilldown for returned KalturaRole
			_model.rolesModel.newRole = data.data[1] as KalturaUserRole;
			_model.rolesModel.newRole = null;
			
			var response:KalturaUserRoleListResponse = data.data[2] as KalturaUserRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
			_model.decreaseLoadCounter();
		} 
	}
}