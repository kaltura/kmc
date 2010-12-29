package com.kaltura.kmc.modules.admin.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaUser;
	
	public class UserEvent extends CairngormEvent {
		
		public static const CHECK_USER_EXIST:String = "admin_checkUserExist";
		public static const ADD_USER:String = "admin_addUser";
		public static const UPDATE_USER:String = "admin_updateUser";
		public static const DELETE_USER:String = "admin_deleteUser";
		public static const TOGGLE_USER_STATUS:String = "admin_toggleUserStatus";
		public static const SELECT_USER:String = "admin_selectUser";
		
		
		private var _user:KalturaUser;
		
		public function UserEvent(type:String, user:KalturaUser = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_user = user;
		}

		public function get user():KalturaUser
		{
			return _user;
		}

	}
}