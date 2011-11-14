package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.clips.*;
	import com.kaltura.edw.control.events.ClipEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class ClipsTabController extends KMvCController {
		
		public function ClipsTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			
			addCommand(ClipEvent.GET_ENTRY_CLIPS, GetEntryClipsCommand);
			addCommand(ClipEvent.RESET_MODEL_ENTRY_CLIPS, ResetEntryClipsCommand);
		}
	}
}