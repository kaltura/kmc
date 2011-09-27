package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaUpdateContent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;

	public class UpdateMediaCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:MediaEvent = event as MediaEvent;
			// e.data here is {conversionProfileId, resource}
			var mu:MediaUpdateContent = new MediaUpdateContent(e.entry.id, e.data.resource, e.data.conversionProfileId);
			mu.addEventListener(KalturaEvent.COMPLETE, result);
			mu.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mu);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			// to update the flavors tab, we re-load flavors data
			if(_model.entryDetailsModel.selectedEntry != null) {
				var cgEvent : EntryEvent = new EntryEvent(EntryEvent.GET_FLAVOR_ASSETS, _model.entryDetailsModel.selectedEntry);
				cgEvent.dispatch();
				cgEvent = new EntryEvent(EntryEvent.UPDATE_SELECTED_ENTRY_REPLACEMENT_STATUS, null,_model.entryDetailsModel.selectedEntry.id);
				cgEvent.dispatch();
			}
		}
	}
}