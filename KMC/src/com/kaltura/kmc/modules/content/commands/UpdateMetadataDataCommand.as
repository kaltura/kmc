package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class UpdateMetadataDataCommand extends KalturaCommand implements ICommand {
		
		override public function execute(event:CairngormEvent):void
		{
			// event.data is an object of the form {entries, tableId}
			_model.entryDetailsModel.metadataInfo.metadataDataObject[event.data.tableId] = event.data.entries;
		}
	}
}