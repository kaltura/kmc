package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.UploadTokenCommand;
	import com.kaltura.edw.control.commands.relatedFiles.*;
	import com.kaltura.edw.control.events.RelatedFileEvent;
	import com.kaltura.edw.control.events.UploadTokenEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class RelatedTabController extends KMvCController {
		
		public function RelatedTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(RelatedFileEvent.SAVE_ALL_RELATED, SaveRelatedFilesCommand);
			addCommand(RelatedFileEvent.LIST_RELATED_FILES, ListRelatedFilesCommand);
			addCommand(RelatedFileEvent.UPDATE_RELATED_FILE, UpdateRelatedFileCommand);
			
			addCommand(UploadTokenEvent.UPLOAD_TOKEN, UploadTokenCommand);
		}
	}
}