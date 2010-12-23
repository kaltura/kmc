package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.userRole.UserRoleDelete;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import mx.collections.ArrayCollection;

	public class DeleteRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			// delete
			var call:KalturaCall = new UserRoleDelete((event as RoleEvent).role.id());
			mr.addAction(call);
			// list
			call = new UserRoleList(_model.rolesModel.rolesFilter);
			mr.addAction(call);
			
			// post
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(mr);
		}
		
		override protected function result(data:Object):void {
			//TODO + note the optional response of "still have users associated with role"
			super.result(data);
			var response:KalturaUserRoleListResponse = data.data[1] as KalturaUserRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
		}
	}
}