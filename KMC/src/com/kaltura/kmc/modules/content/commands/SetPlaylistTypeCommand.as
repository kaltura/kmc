package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	/**
	 * set the _model.manualPlaylistWindowModel.onTheFlyPlaylistType 
	 * to manual, to rule based or to none
	 */
	public class SetPlaylistTypeCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.onTheFlyPlaylistType = event.type;
		}
	}
}