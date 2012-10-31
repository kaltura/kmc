package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.media.MediaGet;
	import com.kaltura.commands.report.ReportGetGraphs;
	import com.kaltura.commands.report.ReportGetTable;
	import com.kaltura.commands.report.ReportGetTotal;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import mx.rpc.IResponder;

	public class GetAllReportsCommand implements ICommand, IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		private var _callGetGraph : Boolean = false;
		private var _callGetTotal : Boolean = false;
		private var _callGetTable : Boolean = false;
		private var _callGetEntry : Boolean = false;
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			ExecuteReportHelper.reportSetupBeforeExecution();
			
			var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport(_model.filter);
			
			if(!_model.selectedReportData.pager)
			{
				_model.selectedReportData.pager = new KalturaFilterPager();
				_model.selectedReportData.pager.pageSize = ReportData.DEF_PAGER_SIZE;
				_model.selectedReportData.pager.pageIndex = 1;
			}
			
			if( (event as ReportEvent).orderBy )
				_model.selectedReportData.orderBy = (event as ReportEvent).orderBy;
				
			var objectIds : String = '';
			if(_model.selectedEntry &&  
				( _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				  _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN) )
			{
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var mr : MultiRequest = new MultiRequest();
			
			_callGetGraph = (event as ReportEvent).getGraph;
			_callGetTotal = (event as ReportEvent).getTotal;
			_callGetTable = (event as ReportEvent).getTable;
			_callGetEntry = (event as ReportEvent).getEntry;
			if( _callGetGraph )
			{
				var reportGetGraphs : ReportGetGraphs = new ReportGetGraphs( (event as ReportEvent).reportType , krif , _model.selectedReportData.selectedDim , objectIds);
				mr.addAction( reportGetGraphs );
			}
					
			if( _callGetTotal )	
			{			
				var reportGetTotal : ReportGetTotal = new ReportGetTotal( (event as ReportEvent).reportType , krif , objectIds);
				mr.addAction( reportGetTotal );
			}
			
			if( _callGetTable )
			{
				var reportGetTable : ReportGetTable = new ReportGetTable( (event as ReportEvent).reportType , krif , _model.selectedReportData.pager , _model.selectedReportData.orderBy , objectIds);
				mr.addAction( reportGetTable );
			}
			
			if( _callGetEntry )
			{
				var mediaGet : MediaGet = new MediaGet( _model.selectedEntry );
				mr.addAction( mediaGet );
			}

			mr.addEventListener( KalturaEvent.COMPLETE , result );
			mr.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( mr );
		}
		
		public function result( result:Object ):void
		{
			_model.loadingFlag = false;
			var resultArr : Array = result.data as Array;

			if( _callGetGraph ) 
			{
				var getGraphsCommand : GetGraphsCommand = new GetGraphsCommand();
				getGraphsCommand.result( {data:resultArr[0] } );
			}
			
			if( _callGetTotal )
			{
				var getTotalCommand : GetTotalCommand = new GetTotalCommand();
				
				if(_model.currentScreenState == ScreenTypes.MAP_OVERLAY)
					getTotalCommand.result( {data:resultArr[0] } );
				else
					getTotalCommand.result( {data:resultArr[1] } );	
			}	
			
			if( _callGetTable ) 
			{
				var getTableCommand : GetTableCommand = new GetTableCommand();
				if(_model.currentScreenState == ScreenTypes.MAP_OVERLAY)
					getTableCommand.result( {data:resultArr[1] } );
				else
					getTableCommand.result( {data:resultArr[2] } );
			}
			else if( _callGetEntry )
			{
				var getMediaEntryCommand : GetMediaEntryCommand = new GetMediaEntryCommand();
				getMediaEntryCommand.result( { data:resultArr[2] } );
			}
		}
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
		}
		
	}
}