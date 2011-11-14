package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.UploadTokenCommand;
	import com.kaltura.edw.control.commands.captions.*;
	import com.kaltura.edw.control.events.CaptionsEvent;
	import com.kaltura.edw.control.events.UploadTokenEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class CaptionsTabController extends KMvCController {
		
		public function CaptionsTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(CaptionsEvent.LIST_CAPTIONS, ListCaptionsCommand);
			addCommand(CaptionsEvent.SAVE_ALL, SaveCaptionsCommand);
			addCommand(CaptionsEvent.UPDATE_CAPTION, GetCaptionDownloadUrl);
			addCommand(UploadTokenEvent.UPLOAD_TOKEN, UploadTokenCommand);
		}
	}
}