package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmvc.model.KMvCModel;

	public class CloseWindowCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			
			switch (_model.windowState) {
				case WindowsStates.REPLACEMENT_ENTRY_DETAILS_WINDOW:
					// in this case we still have another drilldown open
					KMvCModel.removeModel();
					_model.windowState = WindowsStates.ENTRY_DETAILS_WINDOW_CLOSED_ONE;
					break;
				
				case WindowsStates.ENTRY_DETAILS_WINDOW_SA:
					KMvCModel.removeModel();
					_model.windowState = WindowsStates.NONE;
					break;
				
				default:
					if(_model.windowState == WindowsStates.NONE ) {
						_model.windowState = ""; //refresh the close state (in order to close window number 2)
					}
					_model.windowState = WindowsStates.NONE;	
			}
			
			
			
			//in this case we still have another drilldown open
//			if (_model.windowState == WindowsStates.REPLACEMENT_ENTRY_DETAILS_WINDOW) {
//				KMvCModel.removeModel();
//				_model.windowState = WindowsStates.ENTRY_DETAILS_WINDOW_CLOSED_ONE;
//			}
//			else {
//				if(_model.windowState == WindowsStates.NONE ) {
//					_model.windowState = ""; //refrash the close state (in order to close window number 2)
//				}
//				_model.windowState = WindowsStates.NONE;
//			}
		}
	}
}