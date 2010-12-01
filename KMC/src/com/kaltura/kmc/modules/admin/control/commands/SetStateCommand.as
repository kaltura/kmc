package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.events.DrilldownEvent;

	public class SetStateCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case DrilldownEvent.ROLES_SET_STATE:
						_model.rolesModel.drilldownMode = (event as DrilldownEvent).state;
					break;
				case DrilldownEvent.USERS_SET_STATE:
						_model.usersModel.drilldownMode = (event as DrilldownEvent).state;
					break;
			}
		}
	}
}