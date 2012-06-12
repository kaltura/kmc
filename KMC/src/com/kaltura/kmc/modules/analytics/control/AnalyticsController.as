package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.analytics.commands.*;

	public class AnalyticsController extends FrontController
	{
		public function AnalyticsController()
		{
			initializeCommands();
		}
		
		public function initializeCommands() : void
		{
			//State Event
			addCommand( StateEvent.STATE_CHANGE , StateChangeCommand );
			
			//Report Event
			addCommand( ReportEvent.GET_GRAPH , GetGraphsCommand );
			addCommand( ReportEvent.GET_TOTAL , GetTotalCommand );
			addCommand( ReportEvent.GET_TABLE , GetTableCommand );
			addCommand( ReportEvent.GET_BASE_TOTALS , GetBaseTotalsCommand );
			addCommand( ReportEvent.GET_MULTI_DATA , GetAllReportsCommand );
			addCommand( ReportEvent.EXPORT_TO_EXCEL , ExportToExcelCommand );
			
			addCommand( ReportDataEvent.SET_REPORT_DATA, SetReportDataCommand );
			
			//Command Event
			addCommand( GraphEvent.CHANGE_DIM , ChangeDimCommand );
			
			//Drill Down Event
			addCommand( DrillDownEvent.DRILL_DOWN , DrillDownCommand );
			addCommand( DrillDownEvent.GET_MEDIA_ENTRY , GetMediaEntryCommand );
			
			//Page Event
			addCommand( PageEvent.PAGE_CHANGE , PageCommand );
			
			// Partner Events
			addCommand( PartnerEvent.GET_PARTNER_INFO , GetPartnerInfoCommand );
			
			// Partner Usage Event
			addCommand(UsageGraphEvent.USAGE_GRAPH, GetUsageGraphCommand );
			
			// Categories Event
			addCommand(CategoryEvent.LIST_CATEGORIES, ListCategoriesCommand );
			
			// permissions events
			addCommand(PermissionEvent.REMOVE_REPORT, RemoveReportCommand );
			
			// lsit partner applications
			addCommand( PartnerEvent.GET_PARTNER_APPLICATIONS, GetApplicationsCommand );
			
		}
	}
}