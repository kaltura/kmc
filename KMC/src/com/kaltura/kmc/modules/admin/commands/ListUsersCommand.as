package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.ListUsersEvent;
	import com.kaltura.kmc.modules.admin.model.AdminModelLocator;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListUsersCommand extends BaseCommand {
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			var e:ListUsersEvent = event as ListUsersEvent;
			var ul:UserList = new UserList(e.filter, e.pager);
			ul.addEventListener(KalturaEvent.COMPLETE, result);
			ul.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(ul);
		}
		
		
		
		/**
		 * set received data on model
		 * @param data data returned from server.
		 */
		override public function result(data:Object):void {
			super.result(data);
			var response:KalturaUserListResponse = data.data as KalturaUserListResponse;
			_model.usersModel.users = new ArrayCollection(response.objects);
			_model.usersModel.totalUsers = response.totalCount;
		}
	}
}