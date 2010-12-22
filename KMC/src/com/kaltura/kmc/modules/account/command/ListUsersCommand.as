package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.types.KalturaUserStatus;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import flash.display.Graphics;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexSprite;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import mx.states.AddChild;

	public class ListUsersCommand implements ICommand {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var filter:KalturaUserFilter = new KalturaUserFilter();
			filter.isAdminEqual = true;
			filter.loginEnabledEqual = true;
			filter.statusEqual = KalturaUserStatus.ACTIVE;
			// server can't filter by user role
			var ul:UserList = new UserList(filter);
			ul.addEventListener(KalturaEvent.COMPLETE, result);
			ul.addEventListener(KalturaEvent.FAILED, fault);

			_model.context.kc.post(ul);
		}


		private function result(event:KalturaEvent):void {
			// filter only the admin users
			var orig:Array = (event.data as KalturaUserListResponse).objects;
			var result:Array = [];
			for each (var user:KalturaUser in orig) {
				if (user.roleIds == '3') {
					result.push(user);
				}
			}
			_model.usersList = new ArrayCollection(result);
		}


		private function fault(event:KalturaEvent):void {
			if (event.error) {
				Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			}
		}
	}
}