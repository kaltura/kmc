package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;

	/**
	 * This class sets the selected entries in the model
	 * */
	public class SetSelectedEntriesCommand extends KalturaCommand
	{
		
		/**
		 * set selected entries on the model
		 */
		override public function execute(event:CairngormEvent):void
		{
			_model.selectedEntries = (event as EntriesEvent).entries.source;	
		}
	}
}