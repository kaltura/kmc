package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SelectionEvent;
	
	public class SelectionCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.selectedEntries = (event as SelectionEvent).entries;
		}

	}
}