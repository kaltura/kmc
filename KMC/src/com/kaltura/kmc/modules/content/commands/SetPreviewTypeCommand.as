package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	/**
	 * set the _model.rulePlaylistWindowModel.rulePlaylistType the type of the rule based preview 
	 * one rule or multiple rules
	 */
	public class SetPreviewTypeCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.rulePlaylistType = event.type;
		}
	}
}