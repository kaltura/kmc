package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.kmc.modules.content.model.types.EntryTypes;

	public class SetSelectedEntryCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.entryDetailsModel.selectedEntry = (event as EntryEvent).entryVo;	
		}
	}
}