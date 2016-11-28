package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.ListLiveConversionProfilesCommand;
	import com.kaltura.edw.control.commands.RegenerateLiveTokenCommand;
	import com.kaltura.edw.control.events.LiveEvent;
	import com.kaltura.edw.control.events.ProfileEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class LivestreamTabController extends KMvCController {
		
		public function LivestreamTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(ProfileEvent.LIST_LIVE_CONVERSION_PROFILES, ListLiveConversionProfilesCommand);
			addCommand(LiveEvent.REGENERATE_LIVE_TOKEN, RegenerateLiveTokenCommand);
		}
	}
}