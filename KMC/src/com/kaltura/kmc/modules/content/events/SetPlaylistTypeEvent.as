package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SetPlaylistTypeEvent extends CairngormEvent
	{
		public static const MANUAL_PLAYLIST:String = "manualPlaylist";
		public static const RULE_BASED_PLAYLIST:String = "ruleBasedPlaylist";
		
		public function SetPlaylistTypeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}