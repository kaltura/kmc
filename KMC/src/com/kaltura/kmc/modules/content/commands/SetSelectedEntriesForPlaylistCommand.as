package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;

	public class SetSelectedEntriesForPlaylistCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.onTheFlyPlaylistEntries = (event as EntriesEvent).entries;	
		}
	}
}