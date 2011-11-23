package com.kaltura.edw.control.commands {
	import com.kaltura.commands.mixing.MixingGetReadyMediaEntries;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.ContentDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;

	public class GetAllEntriesCommand extends KedCommand {
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var cdp:ContentDataPack = _model.getDataPack(ContentDataPack) as ContentDataPack;
			cdp.contentParts = null;
			
			var e:KedEntryEvent = event as KedEntryEvent;
			var getMediaReadyMix:MixingGetReadyMediaEntries = new MixingGetReadyMediaEntries(e.entryVo.id);

			getMediaReadyMix.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaReadyMix.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(getMediaReadyMix);
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (data.data && data.data is Array) {
				var cdp:ContentDataPack = _model.getDataPack(ContentDataPack) as ContentDataPack;
				cdp.contentParts = data.data;
			}
			else
				trace("Error getting the list of roughcut entries");
		}
	}
}