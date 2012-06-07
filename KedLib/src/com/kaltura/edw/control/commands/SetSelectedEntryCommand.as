package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.edw.business.EntryUtil;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class SetSelectedEntryCommand extends KedCommand
	{
		private var _edp:EntryDataPack;
		
		override public function execute(event:KMvCEvent):void
		{	
			_edp = _model.getDataPack(EntryDataPack) as EntryDataPack;
			_edp.selectedIndex = (event as KedEntryEvent).entryIndex;
			if ((event as KedEntryEvent).reloadEntry) {
				_model.increaseLoadCounter();
				var getEntry:BaseEntryGet = new BaseEntryGet((event as KedEntryEvent).entryVo.id);
				
				getEntry.addEventListener(KalturaEvent.COMPLETE, result);
				getEntry.addEventListener(KalturaEvent.FAILED, fault);
				
				_client.post(getEntry);
			}
//			else {
			_edp.selectedEntry = (event as KedEntryEvent).entryVo;	
//			}
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && data.data is KalturaBaseEntry) {
				// update values on the existing entry in the list
				var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_UPDATED);
				e.data = data.data as KalturaBaseEntry; // send the updated entry as event data
				(_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher.dispatchEvent(e);
			}
			_model.decreaseLoadCounter();
		}
	}
}