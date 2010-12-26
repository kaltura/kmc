package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.userRole.UserRoleList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.ListItemsEvent;
	import com.kaltura.vo.KalturaUserRoleFilter;
	import com.kaltura.vo.KalturaUserRoleListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListRolesCommand extends BaseCommand {
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			var e:ListItemsEvent = event as ListItemsEvent;
			var ul:UserRoleList = new UserRoleList(e.filter as KalturaUserRoleFilter, e.pager);
			ul.addEventListener(KalturaEvent.COMPLETE, result);
			ul.addEventListener(KalturaEvent.FAILED, fault);
			if (_model.kc) {
				_model.increaseLoadCounter();
				_model.kc.post(ul);
			}
		}
		
		
		/**
		 * set received data on model
		 * @param data data returned from server.
		 */
		override protected function result(data:Object):void {
			super.result(data);
			var response:KalturaUserRoleListResponse = data.data as KalturaUserRoleListResponse;
			_model.rolesModel.roles = new ArrayCollection(response.objects);
			_model.rolesModel.totalRoles = response.totalCount;
			_model.decreaseLoadCounter();
		}
		
	}
}