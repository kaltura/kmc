package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.StateEvent;
	import com.kaltura.kmc.modules.analytics.model.KMCModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;

	public class StateChangeCommand implements ICommand
	{
		private var _model : KMCModelLocator =  KMCModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			var newStae : int = (event as StateEvent).newState;
			_model.currentScreenState = newStae;
			_model.filter.keywords = "";
			
			switch(newStae)
			{
				case ScreenTypes.MAP_OVERLAY_DRILL_DOWN:
				case ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN:
				case ScreenTypes.TOP_CONTRIBUTORS: DrillDownLinkButton.linkable = false; break;
				default: DrillDownLinkButton.linkable = true; break;
			}
			
			if(_model.reportDataMap[newStae])
				_model.selectedReportData = _model.reportDataMap[newStae];
			else
				_model.selectedReportData = _model.reportDataMap[newStae] = new ReportData();
		}
	}
}