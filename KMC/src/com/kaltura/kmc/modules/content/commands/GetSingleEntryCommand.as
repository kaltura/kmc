package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.business.Cloner;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.utils.EntryUtil;
	import com.kaltura.types.KalturaEntryReplacementStatus;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import modules.Content;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.PropertyChangeEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetSingleEntryCommand extends KalturaCommand implements ICommand, IResponder {

		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:EntryEvent = event as EntryEvent;
			_eventType = e.type;
			if (_eventType == EntryEvent.GET_SELECTED_ENTRY) {
				_model.entryDetailsModel.selectedEntryReloaded = false;
			}
			
			var getEntry:BaseEntryGet = new BaseEntryGet(e.entryId);

			getEntry.addEventListener(KalturaEvent.COMPLETE, result);
			getEntry.addEventListener(KalturaEvent.FAILED, fault);

			_model.context.kc.post(getEntry);
		}


		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && data.data is KalturaBaseEntry) {
				var resultEntry:KalturaBaseEntry = data.data as KalturaBaseEntry;
				if (_eventType == EntryEvent.GET_REPLACEMENT_ENTRY) {
					_model.entryDetailsModel.selectedReplacementEntry = resultEntry;
				}
				else if (_eventType == EntryEvent.GET_SELECTED_ENTRY) {
					EntryUtil.updateChangebleFieldsOnly(resultEntry);
					_model.entryDetailsModel.selectedEntry.dispatchEvent(PropertyChangeEvent.createUpdateEvent(_model.entryDetailsModel.selectedEntry, 'replacementStatus',
						_model.entryDetailsModel.selectedEntry.replacementStatus,_model.entryDetailsModel.selectedEntry.replacementStatus));
					//if in the entries list there's an entry with the same id, replace it.
					EntryUtil.updateSelectedEntryInList(_model.entryDetailsModel.selectedEntry);
					_model.entryDetailsModel.selectedEntryReloaded = true;
				}
				else {
					(_model.app as Content).requestEntryDrilldown(data.data);
				}
			}
			else {
				trace("Error getting entry");
			}
			_model.decreaseLoadCounter();
		}

		
		override public function fault(info:Object):void {
			//if entry replacement doesn't exist it means that the replacement is ready
			if ((_eventType == EntryEvent.GET_REPLACEMENT_ENTRY) || (_eventType == EntryEvent.GET_SELECTED_ENTRY)) {
				var er:KalturaError = (info as KalturaEvent).error;
				if (er.errorCode == APIErrorCode.ENTRY_ID_NOT_FOUND) {
					_model.decreaseLoadCounter();
					return;
				}
			}

			super.fault(info);
		}
	}
}