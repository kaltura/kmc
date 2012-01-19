package com.kaltura.edw.control
{
	import com.kaltura.edw.control.commands.GetSingleEntryCommand;
	import com.kaltura.edw.control.commands.ListFlavorAssetsByEntryIdCommand;
	import com.kaltura.edw.control.commands.dist.*;
	import com.kaltura.edw.control.commands.thumb.ListThumbnailAssetCommand;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.ThumbnailAssetEvent;
	import com.kaltura.kmvc.control.KMvCController;
	
	public class DistributionTabController extends KMvCController {
		
		public function DistributionTabController()
		{
			initializeCommands();
		}
		
		public function initializeCommands():void {
			addCommand(ThumbnailAssetEvent.LIST, ListThumbnailAssetCommand);
			
			addCommand(KedEntryEvent.GET_FLAVOR_ASSETS, ListFlavorAssetsByEntryIdCommand);
			addCommand(KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, GetSingleEntryCommand);
			
			addCommand(EntryDistributionEvent.LIST, ListEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE_LIST, UpdateEntryDistributionsCommand);
			addCommand(EntryDistributionEvent.SUBMIT, SubmitEntryDistributionCommand);
			addCommand(EntryDistributionEvent.SUBMIT_UPDATE, SubmitUpdateEntryDistributionCommand);
			addCommand(EntryDistributionEvent.UPDATE, UpdateEntryDistributionCommand);
			addCommand(EntryDistributionEvent.RETRY, RetryEntryDistributionCommand);
			addCommand(EntryDistributionEvent.GET_SENT_DATA, GetSentDataEntryDistributionCommand);
			addCommand(EntryDistributionEvent.GET_RETURNED_DATA, GetReturnedDataEntryDistributionCommand);
		}
	}
}