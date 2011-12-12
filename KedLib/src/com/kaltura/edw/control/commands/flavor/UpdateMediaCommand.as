package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.commands.media.MediaUpdateContent;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.edw.control.commands.KedCommand;

	public class UpdateMediaCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			_dispatcher = event.dispatcher;
			var e:MediaEvent = event as MediaEvent;
			// e.data here is {conversionProfileId, resource}
			var mu:MediaUpdateContent = new MediaUpdateContent(e.entry.id, e.data.resource, e.data.conversionProfileId);
			mu.addEventListener(KalturaEvent.COMPLETE, result);
			mu.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(mu);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			// to update the flavors tab, we re-load flavors data
			var selectedEntry:KalturaBaseEntry = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry;
			if(selectedEntry != null) {
				var cgEvent : KedEntryEvent = new KedEntryEvent(KedEntryEvent.GET_FLAVOR_ASSETS, selectedEntry);
				_dispatcher.dispatch(cgEvent);
				cgEvent = new KedEntryEvent(KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, null,selectedEntry.id);
				_dispatcher.dispatch(cgEvent);
			}
		}
	}
}