package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
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