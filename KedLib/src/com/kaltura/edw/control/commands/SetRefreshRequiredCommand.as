package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.SetRefreshRequiredEvent;

	public class SetRefreshRequiredCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.refreshEntriesRequired = (event as SetRefreshRequiredEvent).value;
		}
	}
}