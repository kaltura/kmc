package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	/**
	 * remove an entry vo from the checked entries list 
	 */	
	public class RemoveCheckedEntryCommand extends KalturaCommand
	{
		 
		override public function execute(event:CairngormEvent):void
		{
			var entryVo:KalturaBaseEntry = (event as EntryEvent).entryVo
			_model.entryDetailsModel.selectedEntry = entryVo;
			if( _model.checkedEntries.contains(entryVo)) { 
				_model.checkedEntries.removeItemAt(_model.checkedEntries.getItemIndex(entryVo));
			}
		}
	
	}
}