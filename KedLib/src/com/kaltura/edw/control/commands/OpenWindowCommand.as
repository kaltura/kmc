package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.WindowEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class OpenWindowCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
		
			var newState : String = (event as WindowEvent).windowState;
			
			//if the current state is the same as the asked on (drill down in drill down)
			//close the opend window and open other insted
			if(newState == _model.windowState)
				_model.windowState = WindowsStates.NONE;
				
			switch(newState)
			{
				case WindowsStates.DOWNLOAD_WINDOW: 			
				case WindowsStates.ADD_ADMIN_TAGS_WINDOW:
				case WindowsStates.REMOVE_ADMIN_TAGS_WINDOW:
				case WindowsStates.REMOVE_TAGS_WINDOW:
				case WindowsStates.ADD_TAGS_WINDOW: 
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