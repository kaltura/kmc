package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.commands.media.MediaCancelReplace;
	import com.kaltura.edw.business.Cloner;
	import com.kaltura.edw.business.EntryUtil;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	
	import flash.events.IEventDispatcher;


	public class CancelMediaEntryReplacementCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var cancelReplacement:MediaCancelReplace = new MediaCancelReplace((event as MediaEvent).entry.id);
			cancelReplacement.addEventListener(KalturaEvent.COMPLETE, result);
			cancelReplacement.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(cancelReplacement);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && (data.data is KalturaMediaEntry)) {
				var entry:KalturaBaseEntry = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry;
				EntryUtil.updateChangebleFieldsOnly(data.data as KalturaMediaEntry, entry);
				
				var dsp:IEventDispatcher = (_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher;
				var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_RELOADED);
				e.data = entry; 
				dsp.dispatchEvent(e);
//				EntryUtil.updateSelectedEntryInList(entry, _model.listableVo.arrayCollection);
			}
			else {
				trace ("error in cancel replacement");
			}
			
			_model.decreaseLoadCounter();
		}
	}
}