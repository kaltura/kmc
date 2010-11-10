package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.FilterEvent;

	public class SetFilterToModelCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			
			_model.playlistModel.onTheFlyFilter = (event as FilterEvent).filterVo;
		}
	}
}