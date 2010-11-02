package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.kaltura.kmc.modules.analytics.commands.*;

	public class KMCController extends FrontController
	{
		public function KMCController()
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
			addCommand( ReportEvent.GET_MULTI_DATA , GetAllReportsCommand );
			addCommand( ReportEvent.EXPORT_TO_EXCEL , ExportToExcelCommand );
			
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
		}
	}
}