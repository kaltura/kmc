package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;

	public class ChangeModelValueCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			switch (event.type) {
				case ChangeModelEvent.SET_EMBED_STATUS:
					_model.showEmbedCode = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_CUSTOM_METADATA:
					_model.filterModel.enableCustomData = (event as ChangeModelEvent).newValue;
					break;
			}
		}	
	}
}