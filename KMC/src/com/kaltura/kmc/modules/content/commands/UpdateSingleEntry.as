package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	
	public class UpdateSingleEntry extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var e:EntryEvent = event as EntryEvent;
			
			e.entryVo.setUpdatedFieldsOnly(true);
			
			var mu:BaseEntryUpdate = new BaseEntryUpdate(e.entryId, e.entryVo);
			// add listeners and post call
			mu.addEventListener(KalturaEvent.COMPLETE, result);
			mu.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mu);
		
			
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			//TODO do we need to do anything?
			
		}
	}
}