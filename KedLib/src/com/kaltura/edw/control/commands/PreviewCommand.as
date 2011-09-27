package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.edw.model.types.WindowsStates;

	public class PreviewCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.entryDetailsModel.selectedEntry = (event as EntryEvent).entryVo;
			_model.windowState = WindowsStates.PREVIEW;
		}
	}
}