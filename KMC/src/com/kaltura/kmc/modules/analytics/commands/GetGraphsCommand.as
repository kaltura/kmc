package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.commands.report.ReportGetGraphs;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaReportGraph;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetGraphsCommand implements ICommand,IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		private var _executeReportHelper : ExecuteReportHelper = new ExecuteReportHelper();
		
		/**
		 * will execute the request to get all the graph results accourding to the current filter
		 * @param event (ReportEvent) 
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			_model.loadingChartFlag = true;
			
			_executeReportHelper.reportSetupBeforeExecution();
			
			var krif : KalturaReportInputFilter = _executeReportHelper.createFilterFromCurrentReport();
			
			var objectIds : String = '';
			if( _model.selectedEntry &&  
				( _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				  _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN) )
			{
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var reportGetGraphs : ReportGetGraphs = new ReportGetGraphs( (event as ReportEvent).reportType , krif , _model.selectedReportData.selectedDim , objectIds);
			
			reportGetGraphs.addEventListener( KalturaEvent.COMPLETE , result );
			reportGetGraphs.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( reportGetGraphs );
		}
		
		public function result( result : Object ) : void
		{
			_model.loadingChartFlag = false;
			_model.checkLoading();
			
			var krpArr : Array =  result.data as Array;
			
			//_model.reportDataMap[_model.currentScreenState].
			_model.reportDataMap[_model.currentScreenState].dimToChartDpMap = new Object();
			_model.reportDataMap[_model.currentScreenState].dimArrColl = new ArrayCollection();
			
			var firstDim : String = null;
			for(var i:int=0; i<krpArr.length; i++)
			{
				var krp : KalturaReportGraph = KalturaReportGraph(krpArr[i]);
				var pointsArr : Array = krp.data.split(";");
				var graphPoints : ArrayCollection = new ArrayCollection();

				for(var j:int=0; j<pointsArr.length; j++)
				{
					if( pointsArr[j])
					{
						var xYArr : Array = pointsArr[j].split(",");
						if(_model.currentScreenState != ScreenTypes.CONTENT_DROPOFF && _model.currentScreenState != ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF)
						{
							var year : String = String(xYArr[0]).substring(0,4);
							var month : String = String(xYArr[0]).substring(4,6); 	
							var date : String = String(xYArr[0]).substring(6,8);	
							var newDate : Date = new Date( Number(year) , Number(month)-1 , Number(date) );
							
							var timestamp : Number = newDate.time;
							graphPoints.addItem( {x: timestamp,y:xYArr[1]} ); 
						}
						else
						{
							var obj : Object = new Object();
							obj.x = ResourceManager.getInstance().getString('analytics', xYArr[0]);
							obj.y =  xYArr[1]
							graphPoints.addItem( obj );
						}
					}
				}
	
				if(!_model.reportDataMap[_model.currentScreenState])	
					_model.reportDataMap[_model.currentScreenState] = new ReportData();
			
				var dimLbl : String = ResourceManager.getInstance().getString('analytics',krpArr[i].id);
				var dimObj : Object = new Object()
				dimObj.label = dimLbl;
				dimObj.data = krpArr[i].id;
				if(!firstDim) firstDim = dimObj.data;
				(_model.reportDataMap[_model.currentScreenState].dimArrColl as ArrayCollection).addItem( dimObj );
				_model.reportDataMap[_model.currentScreenState].dimToChartDpMap[krpArr[i].id] = graphPoints;
				
				if(!_model.reportDataMap[_model.currentScreenState].selectedDim && i==0)
					_model.reportDataMap[_model.currentScreenState].selectedDim = krpArr[i].id;
			}
			if(_model.currentScreenState != ScreenTypes.CONTENT_DROPOFF && _model.currentScreenState != ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF)
			{
				if(!_model.reportDataMap[_model.currentScreenState].selectedDim)
					_model.reportDataMap[_model.currentScreenState].chartDp = _model.reportDataMap[_model.currentScreenState].dimToChartDpMap[firstDim];
				else
					_model.reportDataMap[_model.currentScreenState].chartDp = _model.reportDataMap[_model.currentScreenState].dimToChartDpMap[_model.reportDataMap[_model.currentScreenState].selectedDim];
			}
			else
				_model.reportDataMap[_model.currentScreenState].chartDp = _model.reportDataMap[_model.currentScreenState].dimToChartDpMap["content_dropoff"];
				
			_model.filter = _model.filter;
			_model.selectedReportData = null; //refreash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];	
		}
		
		public function fault( info : Object ) : void
		{
			_model.reportDataMap[_model.currentScreenState].chartDp = null;
			if(_model.selectedReportData)
				_model.selectedReportData.chartDp = null;
			
			_model.loadingChartFlag = false;
			_model.checkLoading();
			
			if((info as KalturaEvent).error)
			{
				if((info as KalturaEvent).error.errorMsg)
				{
					if((info as KalturaEvent).error.errorMsg.substr(0,10) == "Invalid KS")
					{
						ExternalInterface.call( "expiredF" );
						return;
					}
					else
						Alert.show( (info as KalturaEvent).error.errorMsg , "Error");
				}
			}
		}
	}
}