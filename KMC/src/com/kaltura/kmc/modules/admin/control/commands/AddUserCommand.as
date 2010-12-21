package com.kaltura.kmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.admin.control.events.ListItemsEvent;
	import com.kaltura.kmc.modules.admin.control.events.UserEvent;
	import com.kaltura.kmc.modules.admin.model.DrilldownMode;

	public class AddUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			var ua:UserAdd = new UserAdd((event as UserEvent).user);
			ua.addEventListener(KalturaEvent.COMPLETE, result);
			ua.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(ua);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (data.success) {
				_model.usersModel.drilldownMode = DrilldownMode.NONE;
			}
		}
	}
}