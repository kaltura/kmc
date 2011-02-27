package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;

	public class ChangeModelValueCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			switch (event.type) {
				case ChangeModelEvent.SET_SINGLE_ENTRY_EMBED_STATUS:
					_model.showSingleEntryEmbedCode = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_PLAYLIST_EMBED_STATUS:
					_model.showPlaylistEmbedCode = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_CUSTOM_METADATA:
					_model.filterModel.enableCustomData = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_UPDATE_CUSTOM_DATA:
					_model.entryDetailsModel.enableUpdateMetadata = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_DISTRIBUTION:
					_model.filterModel.enableDistribution = (event as ChangeModelEvent).newValue;
					break;
			}
		}	
	}
}