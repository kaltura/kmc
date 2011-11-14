package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.AddNewAccessControlProfileCommand;
	import com.kaltura.edw.control.commands.ListAccessControlsCommand;
	import com.kaltura.edw.control.events.AccessControlEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class AccessTabController extends KMvCController {
		
		public function AccessTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(AccessControlEvent.ADD_NEW_ACCESS_CONTROL_PROFILE, AddNewAccessControlProfileCommand);
			addCommand(AccessControlEvent.LIST_ACCESS_CONTROLS_PROFILES, ListAccessControlsCommand);
		}
	}
}