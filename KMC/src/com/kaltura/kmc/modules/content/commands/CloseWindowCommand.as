package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;

	public class CloseWindowCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			//in this case we still have another drilldown open
			if (_model.windowState == WindowsStates.REPLACEMENT_ENTRY_DETAILS_WINDOW) {
				_model.entryDetailsModelsArray.pop();
				_model.windowState = WindowsStates.ENTRY_DETAILS_WINDOW_CLOSED_ONE;
			}
			else {
				if(_model.windowState == WindowsStates.NONE ) {
					_model.windowState = ""; //refrash the close state (in order to close window number 2)
				}
				_model.windowState = WindowsStates.NONE;
			}
		}
	}
}