package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.vo.KalturaBaseEntry;

	/**
	 * add an entry vo to the checked entries list 
	 */	
	public class AddCheckedEntryCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			var entryVo:KalturaBaseEntry = (event as EntryEvent).entryVo; 
			_model.entryDetailsModel.selectedEntry = entryVo
			
			if( ! _model.checkedEntries.contains( entryVo ) ) 
				_model.checkedEntries.addItem( entryVo );
		}	
	}
}