package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.SelectionEvent;
	
	public class SelectionCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.selectedEntries = (event as SelectionEvent).entries;
		}

	}
}