package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.ListRolesEvent;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
	
	import mx.collections.ArrayCollection;

	public class ListRolesCommand extends BaseCommand {
		
		//TODO + implement ListRolesCommand when we have services
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
//			var e:ListRolesEvent = event as ListRolesEvent;
//			var ul:UserList = new UserList(e.filter, e.pager);
//			ul.addEventListener(KalturaEvent.COMPLETE, result);
//			ul.addEventListener(KalturaEvent.FAILED, fault);
//			if (_model.kc) {
//				_model.kc.post(ul);
//			}
			result(null);
		}
		
		
		
		/**
		 * set received data on model
		 * @param data data returned from server.
		 */
		override public function result(data:Object):void {
//			super.result(data);
//			var response:KalturaUserListResponse = data.data as KalturaUserListResponse;
//			_model.usersModel.users = new ArrayCollection(response.objects);
//			_model.usersModel.totalUsers = response.totalCount;
			_model.usersModel.allRoles = generateAllRoles();
		}
		
		
		private function generateAllRoles():ArrayCollection {
			var ar:Array = new Array();
				
			var role:KalturaRole = new KalturaRole();
			role.id = 1;
			role.name = "my First Role";
			role.description = "Description of my first role";
			role.permissions = "1,2,3";
			ar.push(role);
			
			role = new KalturaRole();
			role.id = 2;
			role.name = "my second Role";
			role.description = "Description of my second role";
			role.permissions = "23,40,33";
			ar.push(role);
			
			role = new KalturaRole();
			role.id = 2;
			role.name = "my Third Role";
			role.description = "Description of my THIRD role";
			role.permissions = "34,2,56";
			ar.push(role);
			
			return new ArrayCollection(ar);
		}
	}
}