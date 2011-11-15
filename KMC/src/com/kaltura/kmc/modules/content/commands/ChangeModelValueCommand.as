package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.datapacks.PermissionsDataPack;
	import com.kaltura.kmc.modules.content.events.ChangeModelEvent;
	import com.kaltura.kmvc.model.KMvCModel;

	public class ChangeModelValueCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			var pdp:PermissionsDataPack = KMvCModel.getInstance().getDataPack(PermissionsDataPack) as PermissionsDataPack;;
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
						pdp.enableUpdateMetadata = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_DISTRIBUTION: 
					_model.filterModel.enableDistribution = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_REMOTE_STORAGE:
						pdp.remoteStorageEnabled = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_ENABLE_THUMB_RESIZE:
						pdp.enableThumbResize = (event as ChangeModelEvent).newValue;
					break;
				case ChangeModelEvent.SET_ENABLE_THUMBS_LIST:
						pdp.enableThumbsList = (event as ChangeModelEvent).newValue;
					break;
			}
		}
	}
}