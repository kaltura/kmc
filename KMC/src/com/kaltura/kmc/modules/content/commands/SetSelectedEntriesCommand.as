package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	
	import mx.collections.ArrayCollection;

	/**
	 * This class sets the selected entries in the model
	 * */
	public class SetSelectedEntriesCommand extends KalturaCommand
	{
		
		/**
		 * set selected entries on the model
		 */
		override public function execute(event:CairngormEvent):void
		{
			switch (event.type) {
				case EntriesEvent.SET_SELECTED_ENTRIES:
					_model.selectedEntries = (event as EntriesEvent).entries.source;
					break;
				case EntriesEvent.SET_SELECTED_ENTRIES_FOR_PLAYLIST:
					_model.playlistModel.onTheFlyPlaylistEntries = new ArrayCollection(_model.selectedEntries);
					break;
				case EntriesEvent.SET_SELECTED_ENTRIES_FOR_CATEGORY:
					_model.categoriesModel.onTheFlyCategoryEntries = _model.selectedEntries;
					break;
			}
		}
	}
}