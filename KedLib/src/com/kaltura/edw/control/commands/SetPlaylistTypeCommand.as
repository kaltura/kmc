package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.SetPlaylistTypeEvent;

	/**
	 * set the _model.playlistModel.onTheFlyPlaylistType 
	 * to manual, to rule based or to none
	 */
	public class SetPlaylistTypeCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.onTheFlyPlaylistType = event.type;
			if (event.type == SetPlaylistTypeEvent.NONE_PLAYLIST) {
				_model.playlistModel.onTheFlyPlaylistEntries = null;
			}
		}
	}
}