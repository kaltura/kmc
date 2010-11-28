package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.admin.commands.*;

	public class AdminController extends FrontController
	{
		public function AdminController()
		{
			initializeCommands();
		}
		
		public function initializeCommands() : void
		{
			
			// ListUser Events
			addCommand( ListUsersEvent.LIST_USERS, ListUsersCommand );
			
			// User Events
			addCommand( UserEvent.SELECT_USER, SelectUserCommand );
			addCommand( UserEvent.DELETE_USER, DeleteUserCommand );
			addCommand( UserEvent.TOGGLE_USER_STATUS, ToggleStatusCommand );
			
			addCommand( UserEvent.UPDATE_USER, BaseCommand );
			addCommand( UserEvent.ADD_USER, BaseCommand );
			
		}
	}
}