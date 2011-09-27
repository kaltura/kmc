package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	public class SetSelectedEntryCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{	
			_model.entryDetailsModel.selectedIndex = (event as EntryEvent).entryIndex;
			if ((event as EntryEvent).reloadEntry) {
				_model.increaseLoadCounter();
				var getEntry:BaseEntryGet = new BaseEntryGet((event as EntryEvent).entryVo.id);
				
				getEntry.addEventListener(KalturaEvent.COMPLETE, result);
				getEntry.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(getEntry);
			}
			else {
				_model.entryDetailsModel.selectedEntry = (event as EntryEvent).entryVo;	
			}
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && data.data is KalturaBaseEntry) {
				_model.entryDetailsModel.selectedEntry = data.data as KalturaBaseEntry;
			}
			_model.decreaseLoadCounter();
		}
	}
}