package com.kaltura.edw.control.commands {
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.edw.business.EntryUtil;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaClipAttributes;
	
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;

	public class GetSingleEntryCommand extends KedCommand {

		private var _eventType:String;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var e:KedEntryEvent = event as KedEntryEvent;
			_eventType = e.type;
			if (_eventType == KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS) {
				(_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntryReloaded = false;
			}
			
			var getEntry:BaseEntryGet = new BaseEntryGet(e.entryId);

			getEntry.addEventListener(KalturaEvent.COMPLETE, result);
			getEntry.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(getEntry);
		}


		override public function result(data:Object):void {
			var clipAttributes:KalturaClipAttributes; // compile this type into KMC
			super.result(data);
			
			if (data.data && data.data is KalturaBaseEntry) {
				var resultEntry:KalturaBaseEntry = data.data as KalturaBaseEntry;
				var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
				var dsp:IEventDispatcher = (_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher;
				if (_eventType == KedEntryEvent.GET_REPLACEMENT_ENTRY) {
					edp.selectedReplacementEntry = resultEntry;
				}
				else if (_eventType == KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS) {
					var selectedEntry:KalturaBaseEntry = edp.selectedEntry;
					EntryUtil.updateChangebleFieldsOnly(resultEntry, selectedEntry);
//					selectedEntry.dispatchEvent(PropertyChangeEvent.createUpdateEvent(selectedEntry, 
//						'replacementStatus', selectedEntry.replacementStatus, selectedEntry.replacementStatus));
					//if in the entries list there's an entry with the same id, replace it.
//					EntryUtil.updateSelectedEntryInList(selectedEntry, _model.listableVo.arrayCollection);
					var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_RELOADED);
					e.data = selectedEntry; 
					dsp.dispatchEvent(e);
					
					edp.selectedEntryReloaded = true;
				}
				else {
					// open drilldown. the request shouldn't come from here, it should come from the env.app
//					/*(*/_model.app/* as Content)*/.requestEntryDrilldown(resultEntry);
					var ee:KedDataEvent = new KedDataEvent(KedDataEvent.OPEN_ENTRY);
					ee.data = resultEntry; 
					dsp.dispatchEvent(ee);
					//TODO when starting KMC with an entry id the dispatcher is still null
				}
			}
			else {
				trace(_eventType, ": Error getting entry");
			}
			_model.decreaseLoadCounter();
		}

		
		override public function fault(info:Object):void {
			//if entry replacement doesn't exist it means that the replacement is ready
			if (_eventType == KedEntryEvent.GET_REPLACEMENT_ENTRY || _eventType == KedEntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS) {
				var er:KalturaError = (info as KalturaEvent).error;
				if (er.errorCode == APIErrorCode.ENTRY_ID_NOT_FOUND) {
					trace("GetSingleEntryCommand 703");
					_model.decreaseLoadCounter();
					return;
				}
			}

			super.fault(info);
		}
	}
}