package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.admin.control.commands.*;
	import com.kaltura.kmc.modules.admin.control.events.*;

	public class AdminController extends FrontController
	{
		public function AdminController()
		{
			initializeCommands();
		}
		
		public function initializeCommands() : void
		{
			
			// ListItems Events
			addCommand( ListItemsEvent.LIST_USERS, ListUsersCommand );
			addCommand( ListItemsEvent.LIST_ROLES, ListRolesCommand);
			addCommand( ListItemsEvent.LIST_PARTNER_PERMISSIONS, ListPartnerPermissionsCommand);
			
			// User Events
			addCommand( UserEvent.SELECT_USER, SelectUserCommand );
			addCommand( UserEvent.DELETE_USER, DeleteUserCommand );
			addCommand( UserEvent.TOGGLE_USER_STATUS, ToggleUserStatusCommand );
			addCommand( UserEvent.UPDATE_USER, UpdateUserCommand );
			addCommand( UserEvent.ADD_USER, AddUserCommand );
			addCommand( UserEvent.CHECK_USER_EXIST, CheckUserExistCommand );
			
			// drilldown events
			addCommand( DrilldownEvent.USERS_SET_STATE, SetStateCommand);
			addCommand( DrilldownEvent.ROLES_SET_STATE, SetStateCommand);
			
			// Role Events
			addCommand( RoleEvent.SELECT_ROLE, SelectRoleCommand);
			addCommand( RoleEvent.DELETE_ROLE, DeleteRoleCommand);
			addCommand( RoleEvent.ADD_ROLE, AddRoleCommand);
			addCommand( RoleEvent.ADD_ROLE_FROM_USERS, AddRoleFromUserCommand);
			addCommand( RoleEvent.UPDATE_ROLE, UpdateRoleCommand);
			addCommand( RoleEvent.DUPLICATE_ROLE, DuplicateRoleCommand);
			
			// partner events
			addCommand( PartnerEvent.GET_PARTNER_DATA, GetPartnerInfoCommand);
			
		}
	}
}