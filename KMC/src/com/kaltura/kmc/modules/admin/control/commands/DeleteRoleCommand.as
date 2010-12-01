package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.RoleEvent;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleDelete;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleList;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleListResponse;
	import com.kaltura.net.KalturaCall;
	
	import mx.collections.ArrayCollection;

	public class DeleteRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			// delete
			var call:KalturaCall = new RoleDelete((event as RoleEvent).role.id.toString());
			mr.addAction(call);
			// list
			call = new RoleList();
			mr.addAction(call);
			// post
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			//TODO note the optional response of "still have users associated with role"
			super.result(data);
			var response:KalturaRoleListResponse = data.data[1] as KalturaRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
		}
	}
}