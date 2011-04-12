package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.dropFolderFile.DropFolderFileDelete;
	import com.kaltura.commands.dropFolderFile.DropFolderFileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.vo.KalturaDropFolderFile;

	public class DeleteDropFolderFilesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var itemsToDelete:Array = (event as DropFolderFileEvent).selectedFiles;
			var mr:MultiRequest = new MultiRequest();
			for each (var file:KalturaDropFolderFile in itemsToDelete) {
				var deleteFile:DropFolderFileDelete = new DropFolderFileDelete(file.id);
				mr.addAction(deleteFile);
			}
			var listFiles:DropFolderFileList = new DropFolderFileList(_model.dropFolderModel.filter, _model.dropFolderModel.pager);
			mr.addAction(listFiles);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			
			_model.decreaseLoadCounter();
		}
	}
}