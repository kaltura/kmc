package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntryFilter;
	import com.kaltura.vo.KalturaBaseEntryListResponse;

	public class ListEntriesByRefidCommand extends KedCommand {
		
		/**
		 * @inheritDoc
		 */		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			var f:KalturaBaseEntryFilter = new KalturaBaseEntryFilter();
			f.referenceIdEqual = (event as KedEntryEvent).entryVo.referenceId;
			var getMediaList:BaseEntryList = new BaseEntryList(f);
			getMediaList.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaList.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(getMediaList);	  
		}
		
		/**
		 * @inheritDoc
		 */
		override public function result(data:Object):void
		{
			super.result(data);
			var recievedData:KalturaBaseEntryListResponse = KalturaBaseEntryListResponse(data.data);
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			edp.entriesWSameRefidAsSelected = recievedData.objects;
			_model.decreaseLoadCounter();
		}
	}
}