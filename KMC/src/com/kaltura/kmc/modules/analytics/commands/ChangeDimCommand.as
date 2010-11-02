package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.GraphEvent;
	import com.kaltura.kmc.modules.analytics.model.KMCModelLocator;

	public class ChangeDimCommand implements ICommand
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			var graphEvent : GraphEvent = event as GraphEvent;	
			_model.reportDataMap[_model.currentScreenState].selectedDim = graphEvent.newDim;
			_model.reportDataMap[_model.currentScreenState].chartDp = _model.reportDataMap[_model.currentScreenState].dimToChartDpMap[graphEvent.newDim];
			
			_model.selectedReportData = null; //refreash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
		}
	}
}