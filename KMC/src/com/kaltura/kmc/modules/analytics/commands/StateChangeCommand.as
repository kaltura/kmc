package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.StateEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;

	/**
	 * inner page changes - sub navigation. 
	 */	
	public class StateChangeCommand implements ICommand {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var newStae:int = (event as StateEvent).newState;
			
			_model.selectedEntry = null;
			
			_model.currentScreenState = newStae;
			_model.filter.keywords = "";
			_model.filter.userIds = "";
			_model.selectedUserId = null;

			switch (newStae) {
				case ScreenTypes.MAP_OVERLAY_DRILL_DOWN:
				case ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN:
				case ScreenTypes.TOP_CONTRIBUTORS:
					//if it's not drilldown make the name null
					_model.drillDownName = null;
					_model.tableSupportDrillDown = false;
				break;
				case ScreenTypes.END_USER_ENGAGEMENT:
				case ScreenTypes.MAP_OVERLAY:
				case ScreenTypes.TOP_SYNDICATIONS:
				case ScreenTypes.CONTENT_CONTRIBUTIONS:
					 //if it's not drilldown make the name null
					_model.drillDownName = null;
					_model.tableSupportDrillDown = true;
					break;	
				case ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN:
					_model.tableSupportDrillDown = false;
					break;
				case ScreenTypes.PBNS:
				case ScreenTypes.END_USER:
					_model.drillDownName = null;
					_model.tableSupportDrillDown = false;
					break;
				default:
					_model.tableSupportDrillDown = true;
				break;
			}

			if (_model.reportDataMap[newStae])
				_model.selectedReportData = _model.reportDataMap[newStae];
			else
				_model.selectedReportData = _model.reportDataMap[newStae] = new ReportData();
			
		}
	}
}