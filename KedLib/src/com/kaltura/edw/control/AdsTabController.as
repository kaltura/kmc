package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.cuepoints.*;
	import com.kaltura.edw.control.events.CuePointEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class AdsTabController extends KMvCController {
		
		public function AdsTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(CuePointEvent.RESET_CUEPOINTS_COUNT, ResetCuePointsCount);
			addCommand(CuePointEvent.COUNT_CUEPOINTS, CountCuePoints);
			addCommand(CuePointEvent.DOWNLOAD_CUEPOINTS, DownloadCuePoints);
			addCommand(CuePointEvent.UPLOAD_CUEPOINTS, UploadCuePoints);
		}
	}
}