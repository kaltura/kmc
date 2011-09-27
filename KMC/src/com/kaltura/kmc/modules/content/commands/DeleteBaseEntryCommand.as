package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntriesEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class DeleteBaseEntryCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var deleteEntry:BaseEntryDelete = new BaseEntryDelete((event as EntryEvent).entryId);
			deleteEntry.addEventListener(KalturaEvent.COMPLETE, result);
			deleteEntry.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(deleteEntry);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
		}
	}
}