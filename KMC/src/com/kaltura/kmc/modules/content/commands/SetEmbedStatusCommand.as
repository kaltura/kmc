package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EmbedStatusEvent;

	public class SetEmbedStatusCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.showEmbedCode = (event as EmbedStatusEvent).embedStatus;
		}	
	}
}