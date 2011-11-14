package com.kaltura.edw.control.commands.dropFolder
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.DropFolderEvent;
	import com.kaltura.edw.model.datapacks.DropFolderDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class SetSelectedFolder extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			var dropFolderData:DropFolderDataPack = _model.getDataPack(DropFolderDataPack) as DropFolderDataPack;
			dropFolderData.selectedDropFolder = (event as DropFolderEvent).folder;
		}
	}
}