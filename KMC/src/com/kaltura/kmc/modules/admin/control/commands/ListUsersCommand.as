package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.ListItemsEvent;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListUsersCommand extends BaseCommand {
		
		/**
		 * @inheritDocs
		 */
		override public function execute(event:CairngormEvent):void {
			var e:ListItemsEvent = event as ListItemsEvent;
			var ul:UserList = new UserList(e.filter as KalturaUserFilter, e.pager);
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
			var response:KalturaUserListResponse = data.data as KalturaUserListResponse;
			var resultArray:ArrayCollection = new ArrayCollection(response.objects);
			setOwnerFirstInArray(resultArray);
			_model.usersModel.users = resultArray;
			_model.usersModel.totalUsers = response.totalCount;
			_model.decreaseLoadCounter();
		}
		
		/**
		 * sets the owner user to be the first user
		 * */
		private function setOwnerFirstInArray(arr:ArrayCollection):void {
			for (var i:int = 0; i<arr.length; i++){
				var user:KalturaUser = arr.getItemAt(i) as KalturaUser;
				if (user.isAccountOwner) {
					arr.removeItemAt(i);
					arr.addItemAt(user,0);
					return;
				}
			}
			
		}
	}
}