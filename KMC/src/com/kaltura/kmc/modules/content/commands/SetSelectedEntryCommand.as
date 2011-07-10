package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.kmc.modules.content.model.types.EntryTypes;
	import com.kaltura.kmc.modules.content.utils.EntryUtil;
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