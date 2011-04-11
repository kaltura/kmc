package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderEvent;
	
	public class SetSelectedFolder extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.dropFolderModel.selectedDropFolder = (event as DropFolderEvent).folder;
		}
	}
}