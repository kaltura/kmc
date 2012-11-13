package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.PageEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;

	public class PageCommand implements ICommand {


		public function execute(event:CairngormEvent):void {
			var model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
			
			model.selectedReportData.pager.pageIndex = (event as PageEvent).currentPage;
			model.selectedReportData.pager.pageSize = (event as PageEvent).currentSize;
//			var reportEvent:ReportEvent = new ReportEvent(ReportEvent.GET_TABLE, (event as PageEvent).reportType, model.currentScreenState);
//			reportEvent.dispatch();
		}
	}
}
