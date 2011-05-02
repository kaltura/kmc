package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SetRefreshRequiredEvent;

	public class SetRefreshRequiredCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.refreshEntriesRequired = (event as SetRefreshRequiredEvent).value;
		}
	}
}