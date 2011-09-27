package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SetPlaylistTypeEvent extends CairngormEvent
	{
		public static const MANUAL_PLAYLIST:String = "content_manualPlaylist";
		public static const RULE_BASED_PLAYLIST:String = "content_ruleBasedPlaylist";
		public static const NONE_PLAYLIST:String = "content_nonePlaylist";
		
		public function SetPlaylistTypeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}