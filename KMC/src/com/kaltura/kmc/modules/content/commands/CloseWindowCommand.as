package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;

	public class CloseWindowCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			if(_model.windowState == WindowsStates.NONE ) {
				_model.windowState = ""; //refrash the close state (in order to close window number 2)
			}
			_model.windowState = WindowsStates.NONE;
		}
	}
}