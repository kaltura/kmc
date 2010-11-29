package com.kaltura.kmc.modules.admin.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.control.DrilldownEvent;

	public class SetStateCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.usersModel.drilldownMode = (event as DrilldownEvent).state;
		}
		
		
	}
}