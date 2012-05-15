package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class OpenWindowCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
		
			var newState : String = (event as WindowEvent).windowState;
			
			//if the current state is the same as the asked one (drill down in drill down)
			//close the opened window and open other instead
			if(newState == _model.windowState)
				_model.windowState = WindowsStates.NONE;
			
			if(_model.windowState == WindowsStates.ENTRY_DETAILS_WINDOW && newState == WindowsStates.ENTRY_DETAILS_WINDOW_SA)
				_model.windowState = WindowsStates.NONE;
							
			switch(newState)
			{
				case WindowsStates.DOWNLOAD_WINDOW: 			
				case WindowsStates.REMOVE_ENTRY_TAGS_WINDOW:
				case WindowsStates.ADD_ENTRY_TAGS_WINDOW: 
				case WindowsStates.REMOVE_CATEGORIES_WINDOW: 
				case WindowsStates.SETTING_ACCESS_CONTROL_PROFILES_WINDOW:
				case WindowsStates.SETTING_SCHEDULING_WINDOW:
					if(_model.selectedEntries.length > 0)
						_model.windowState =  newState;
					else
						Alert.show( ResourceManager.getInstance().getString('cms','pleaseSelectEntriesFirst') , 
									ResourceManager.getInstance().getString('cms','pleaseSelectEntriesFirstTitle') );
				break;
				default: _model.windowState = newState;
			}
			 
		}	
	}
}