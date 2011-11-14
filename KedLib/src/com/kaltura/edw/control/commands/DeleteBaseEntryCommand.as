package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.baseEntry.BaseEntryDelete;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;

	public class DeleteBaseEntryCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var deleteEntry:BaseEntryDelete = new BaseEntryDelete((event as KedEntryEvent).entryId);
			deleteEntry.addEventListener(KalturaEvent.COMPLETE, result);
			deleteEntry.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(deleteEntry);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
		}
	}
}