package com.kaltura.edw.control.commands {
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaLiveStreamEntry;

	public class UpdateSingleEntry extends KedCommand {
		
		private var _event:KedEntryEvent;

		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			
			_event = event as KedEntryEvent;
			var entry:KalturaBaseEntry = _event.entryVo;

			entry.setUpdatedFieldsOnly(true);
			if (entry.status != KalturaEntryStatus.NO_CONTENT && !(entry is KalturaLiveStreamEntry)) {
				entry.conversionProfileId = int.MIN_VALUE;
			}
			// don't send categories - we use categoryEntry service to update them in EntryData panel
			entry.categories = null;
			entry.categoriesIds = null;
			// don't send msDuration, we never have any reason to update it.
			if (entry.msDuration && entry.msDuration != int.MIN_VALUE) {
				entry.msDuration = int.MIN_VALUE;
			}

			var mu:BaseEntryUpdate = new BaseEntryUpdate(entry.id, entry);
			// add listeners and post call
			mu.addEventListener(KalturaEvent.COMPLETE, result);
			mu.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(mu);
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (checkErrors(data)) {
				return;
			}
			
			var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_UPDATED);
			e.data = data.data; // send the updated entry as event data
			(_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher.dispatchEvent(e);

			// this will handle window closing or entry switching after successful save
			if (_event.onComplete != null) {
				_event.onComplete.call(_event.source);
			}
		}
	}
}