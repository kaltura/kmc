package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.ListRolesEvent;
	import com.kaltura.vo.KalturaUserRole;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListRolesCommand extends BaseCommand {
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			var e:ListRolesEvent = event as ListRolesEvent;
			var ul:UserRoleList = new UserRoleList(e.filter, e.pager);
			ul.addEventListener(KalturaEvent.COMPLETE, result);
			ul.addEventListener(KalturaEvent.FAILED, fault);
			if (_model.kc) {
				_model.kc.post(ul);
			}
		}
		
		
		/**
		 * set received data on model
		 * @param data data returned from server.
		 */
		override public function result(data:Object):void {
			super.result(data);
			var response:KalturaUserRoleListResponse = data.data as KalturaUserRoleListResponse;
			_model.usersModel.allRoles = new ArrayCollection(response.objects);
			_model.rolesModel.roles = new ArrayCollection(response.objects);
			_model.rolesModel.totalRoles = response.totalCount;
		}
		
	}
}