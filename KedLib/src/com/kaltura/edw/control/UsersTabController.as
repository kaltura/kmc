package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.usrs.GetEntitledUsersCommand;
	import com.kaltura.edw.control.commands.usrs.GetEntryUserCommand;
	import com.kaltura.edw.control.commands.usrs.SetEntryOwnerCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.UsersEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class UsersTabController extends KMvCController {
		
		public function UsersTabController() {
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(UsersEvent.GET_ENTRY_OWNER, GetEntryUserCommand);
			addCommand(UsersEvent.GET_ENTRY_CREATOR, GetEntryUserCommand);
			addCommand(UsersEvent.RESET_ENTRY_USERS, GetEntryUserCommand);
			addCommand(UsersEvent.SET_ENTRY_OWNER, SetEntryOwnerCommand);
			addCommand(UsersEvent.GET_ENTRY_EDITORS, GetEntitledUsersCommand);
			addCommand(UsersEvent.GET_ENTRY_PUBLISHERS, GetEntitledUsersCommand);
		}
	}
}