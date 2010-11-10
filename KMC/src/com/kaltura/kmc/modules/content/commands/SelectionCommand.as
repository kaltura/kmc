package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SelectionEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	
	import mx.rpc.IResponder;
	
	public class SelectionCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.selectedEntries = (event as SelectionEvent).entries;
		}

	}
}