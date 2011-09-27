package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;
	import com.kaltura.edw.model.EntryDetailsModel;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class ChangeModelValueCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			var edw:EntryDetailsModel;
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
					for each (edw in _model.entryDetailsModelsArray) {
						edw.enableUpdateMetadata = (event as ChangeModelEvent).newValue;
					}
					break;
				case ChangeModelEvent.SET_DISTRIBUTION:
					_model.filterModel.enableDistribution = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_REMOTE_STORAGE:
					for each (edw in _model.entryDetailsModelsArray) {
						edw.remoteStorageEnabled = (event as ChangeModelEvent).newValue;
					}
					break;
				case ChangeModelEvent.SET_ENABLE_THUMB_RESIZE:
					for each (edw in _model.entryDetailsModelsArray) {
						edw.enableThumbResize = (event as ChangeModelEvent).newValue;
					}
					break;
				case ChangeModelEvent.SET_ENABLE_THUMBS_LIST:
					for each (edw in _model.entryDetailsModelsArray) {
						edw.enableThumbsList = (event as ChangeModelEvent).newValue;
					}
					break;
			}
		}	
	}
}