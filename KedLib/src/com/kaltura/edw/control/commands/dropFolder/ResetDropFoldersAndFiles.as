package com.kaltura.edw.control.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	import com.kaltura.edw.control.events.DropFolderEvent;
	
	public class ResetDropFoldersAndFiles extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.dropFolderModel.dropFolderFiles = null;
			_model.dropFolderModel.dropFolders = null;
		}
	}
}