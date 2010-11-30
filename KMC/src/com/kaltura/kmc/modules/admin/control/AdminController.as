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
			addCommand( UserEvent.TOGGLE_USER_STATUS, ToggleUserStatusCommand );
			addCommand( UserEvent.UPDATE_USER, EditUserCommand );
			addCommand( UserEvent.ADD_USER, AddUserCommand );
			
			addCommand( DrilldownEvent.SET_STATE, SetStateCommand);
			
			addCommand( ListRolesEvent.LIST_ROLES, ListRolesCommand);
			
			// Role Events
			addCommand( RoleEvent.SELECT_ROLE, SelectRoleCommand);
			addCommand( RoleEvent.DELETE_ROLE, DeleteRoleCommand);
			addCommand( RoleEvent.ADD_ROLE, AddRoleCommand);
			addCommand( RoleEvent.UPDATE_ROLE, EditRoleCommand);
			addCommand( RoleEvent.DUPLICATE_ROLE, BaseCommand);
			
		}
	}
}