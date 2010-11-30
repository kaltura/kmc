package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.RoleEvent;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleClone;
	import com.kaltura.kmc.modules.admin.stubs.commands.role.RoleList;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleListResponse;
	import com.kaltura.net.KalturaCall;
	
	import mx.collections.ArrayCollection;

	public class DuplicateRoleCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var mr:MultiRequest = new MultiRequest();
			// clone
			var call:KalturaCall = new RoleClone((event as RoleEvent).role.id);
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
			super.result(data);
			var response:KalturaRoleListResponse = data.data[1] as KalturaRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
		} 
	}
}