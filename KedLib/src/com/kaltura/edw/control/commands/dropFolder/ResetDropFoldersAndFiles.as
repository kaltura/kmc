package com.kaltura.edw.control.commands.dropFolder
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.DropFolderDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class ResetDropFoldersAndFiles extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			var dropFolderData:DropFolderDataPack = _model.getDataPack(DropFolderDataPack) as DropFolderDataPack;
			dropFolderData.dropFolderFiles = null;
			dropFolderData.dropFolders = null;
		}
	}
}