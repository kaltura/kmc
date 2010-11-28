package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.UserEvent;

	public class SelectUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.usersModel.selectedUser = (event as UserEvent).user;
		} 
	}
}