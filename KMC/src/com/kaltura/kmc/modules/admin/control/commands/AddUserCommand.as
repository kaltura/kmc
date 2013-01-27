package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.ListItemsEvent;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.commands.user.UserGet;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.events.CloseEvent;
	import com.kaltura.commands.user.UserEnableLogin;

	public class AddUserCommand extends BaseCommand {
		
		private var _user:KalturaUser;
		
		override public function execute(event:CairngormEvent):void {
			// save user for future use
			_user = (event as UserEvent).user;
			// check if the user is listed as end user in the current account (KMS user etc)
			var ua:UserGet = new UserGet((event as UserEvent).user.id);
			ua.addEventListener(KalturaEvent.COMPLETE, getUserResult);
			ua.addEventListener(KalturaEvent.FAILED, getUserFault);
			_model.increaseLoadCounter();
			_model.kc.post(ua);
		}
		
		
		/**
		 * user is not yet listed in the current account, should add. 
		 * */
		private function getUserFault(data:KalturaEvent):void {
			if (data.error.errorCode == "INVALID_USER_ID") {
				addUser();
			}
		}
		
		
		/**
		 * user is already listed in the current account as end user, should update.
		 * */ 
		private function getUserResult(data:KalturaEvent):void {
			var role:String = _user.roleIds
			_user = data.data as KalturaUser;
			_user.roleIds = role;
			var str:String = ResourceManager.getInstance().getString('admin', 'user_exists_current_partner', [_user.id]);
			Alert.show(str, ResourceManager.getInstance().getString('admin', 'add_user_title'), Alert.YES|Alert.NO, null, closeHandler);
		}
		
		
		protected function closeHandler(e:CloseEvent):void {
			switch (e.detail) {
				case Alert.YES:
					updateUser();
					break;
				case Alert.NO:
					// do nothing
					break;
			}
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * update permissions on existing user
		 * */
		private function updateUser():void {
			_user.isAdmin = true;
			//_user.loginEnabled = true;
			var ue:UserEvent = new UserEvent(UserEvent.UPDATE_USER, _user);
			ue.dispatch();
			
			// enable user login
			var ua:UserEnableLogin = new UserEnableLogin(_user.id, _user.email, _user.password);
			ua.addEventListener(KalturaEvent.COMPLETE, enableLoginResult);
			ua.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(ua);
		}
		
		
		private function enableLoginResult(event:KalturaEvent):void {
			// do nothing.
		}
		
		private function addUser():void {
			var ua:UserAdd = new UserAdd(_user);
			ua.addEventListener(KalturaEvent.COMPLETE, addUserResult);
			ua.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(ua);
		}
		
		private function addUserResult(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.drilldownMode = DrilldownMode.NONE;
			}
			_model.decreaseLoadCounter();
		}
	}
}