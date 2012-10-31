package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetGraphs;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaReportBaseTotal;
	import com.kaltura.vo.KalturaReportGraph;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import flash.external.ExternalInterface;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetGraphsCommand implements ICommand,IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		private var _addTotals:Boolean;
		
		private var _graphDataArr : Array;
		private var _baseTotalsWatcher:ChangeWatcher;
		private var _isDataPending:Boolean;
		
		private var _screenType:int;
		/**
		 * will execute the request to get all the graph results accourding to the current filter
		 * @param event (ReportEvent) 
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			_model.loadingChartFlag = true;
			
			_addTotals = (event as ReportEvent).addGraphTotals;
			
			ExecuteReportHelper.reportSetupBeforeExecution();
			
			var reportEvent:ReportEvent = event as ReportEvent;
			if (reportEvent.screenType != -1){
				_screenType = reportEvent.screenType;
			} else {
				_screenType = _model.currentScreenState;
			}

			var objectIds : String = '';
			if( _model.selectedEntry &&  
				( _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || 
					_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || 
					_screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
					_screenType == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || 
					_screenType == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN ||
					_screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) )
			{
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var reportGetGraphs : ReportGetGraphs;
			//If we have a user report call we need to have another filter (that support application and users) 
			//when we generate the report get total call
			if (_screenType == ScreenTypes.END_USER_ENGAGEMENT || 
				_screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN ||
				_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT ||
				_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF ||
				_screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				_screenType == ScreenTypes.END_USER_STORAGE ||
				_screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)
			{
				var keurif : KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.filter);
				
				//in the reports above we need to send playback context instead of categories
				keurif.playbackContext = keurif.categories;
				keurif.categories = null;
				
				reportGetGraphs = new ReportGetGraphs( (event as ReportEvent).reportType , keurif , _model.selectedReportData.selectedDim, objectIds);
			}
			else
			{
				var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport(_model.filter);
				reportGetGraphs = new ReportGetGraphs( (event as ReportEvent).reportType , krif , _model.selectedReportData.selectedDim, objectIds);
			}
			
			reportGetGraphs.queued = false;
			reportGetGraphs.addEventListener( KalturaEvent.COMPLETE , result );
			reportGetGraphs.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( reportGetGraphs );
		}
		
		public function result( result : Object ) : void
		{
			_model.loadingChartFlag = false;
			_model.checkLoading();
			
			_graphDataArr =  result.data as Array;
			
			if (_addTotals && _model.loadingBaseTotals){
				if (_baseTotalsWatcher ){
					_baseTotalsWatcher.unwatch();
				}
				_baseTotalsWatcher = BindingUtils.bindSetter(onBaseTotalsLoaded, _model, ["selectedReportData", "baseTotals"]);
				_isDataPending = true;
			} else {
				parseData();
			}
		}
		
		private function onBaseTotalsLoaded(data:Object):void
		{
			if (data != null){
				if ( _baseTotalsWatcher ) {
					_baseTotalsWatcher.unwatch();
					_baseTotalsWatcher = null;
				}
				if (_isDataPending){
					_isDataPending = false;
					parseData();
				}
			}
		}
		
		private function parseData():void{
			//_model.reportDataMap[_model.currentScreenState].
			_model.reportDataMap[_screenType].dimToChartDpMap = new Object();
			_model.reportDataMap[_screenType].dimArrColl = new ArrayCollection();
			
			var firstDim : String = null;
			for(var i:int=0; i<_graphDataArr.length; i++)
			{
				var krp : KalturaReportGraph = KalturaReportGraph(_graphDataArr[i]);
				
				var pointsArr : Array = krp.data.split(";");
				var graphPoints : ArrayCollection = new ArrayCollection();
				
				if(!_model.reportDataMap[_screenType])	
					_model.reportDataMap[_screenType] = new ReportData();
				
				var dimObj:Object = createDimObject(krp.id);
				if(!firstDim) firstDim = dimObj.data;
				(_model.reportDataMap[_screenType].dimArrColl as ArrayCollection).addItem( dimObj );
				
				// for totals calculation
				var totalPoints : ArrayCollection;
				var totalCounter : Number;
				
				if (_addTotals && krp.id.substr(0,5) == "added"){
					totalPoints = new ArrayCollection();
					var totalDimName:String = "total" + krp.id.slice(5);
					totalCounter = getBaseTotal(totalDimName);
					var totalDimObj:Object = createDimObject(totalDimName);
					
					(_model.reportDataMap[_screenType].dimArrColl as ArrayCollection).addItem( totalDimObj );
				}
				
				for(var j:int=0; j<pointsArr.length; j++)
				{
					if( pointsArr[j])
					{
						var xYArr : Array = pointsArr[j].split(",");
						var yVal:Number = parseFloat(xYArr[1]);
						yVal = isNaN(yVal) ? 0 : yVal;
						if(_screenType != ScreenTypes.CONTENT_DROPOFF && 
							_screenType != ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF)
						{
							// For full dates
							if (String(xYArr[0]).length == 8){
								var date : Date;
								var year : String = String(xYArr[0]).substring(0,4);
								var month : String = String(xYArr[0]).substring(4,6);
							
								var day : String = String(xYArr[0]).substring(6,8);	
								date = new Date( Number(year) , Number(month)-1 , Number(day) );
								
								var timestamp : Number = date.time;
								graphPoints.addItem( {x: timestamp,y: standartize(yVal, krp.id) } );
								
								if (_addTotals && krp.id.substr(0,5) == "added"){
									totalCounter += yVal;
									totalPoints.addItem( {x: timestamp, y: standartize(totalCounter, totalDimName)} );
								}
								
							// for months
							} else {
								graphPoints.addItem( {x: xYArr[0] ,y: standartize(yVal, krp.id) } );
								if (_addTotals && krp.id.substr(0,5) == "added"){
									totalCounter += yVal;
									totalPoints.addItem( {x: xYArr[0], y: standartize(totalCounter, totalDimName)} );
								}
							}
							
							
//							if (_addTotals && krp.id.substr(0,5) == "added"){
//								totalCounter += parseFloat(xYArr[1]);
//								totalPoints.addItem( {x: timestamp, y: standartize(totalCounter, totalDimName)} );
//							}
						}
						else
						{
							var obj : Object = new Object();
							obj.x = ResourceManager.getInstance().getString('analytics', xYArr[0]);
							obj.y =  yVal
							graphPoints.addItem( obj );
						}
					}
				}
	
				
				_model.reportDataMap[_screenType].dimToChartDpMap[krp.id] = graphPoints;
				
				if (_addTotals && krp.id.substr(0,5) == "added"){
					_model.reportDataMap[_screenType].dimToChartDpMap[totalDimName] = totalPoints;
				}
				
				if(!_model.reportDataMap[_screenType].selectedDim && i==0)
					_model.reportDataMap[_screenType].selectedDim = _graphDataArr[i].id;
			}
			if(_screenType != ScreenTypes.CONTENT_DROPOFF && _screenType != ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF)
			{
				if(!_model.reportDataMap[_screenType].selectedDim)
					_model.reportDataMap[_screenType].chartDp = _model.reportDataMap[_screenType].dimToChartDpMap[firstDim];
				else
					_model.reportDataMap[_screenType].chartDp = _model.reportDataMap[_screenType].dimToChartDpMap[_model.reportDataMap[_screenType].selectedDim];
			}
			else
			{
				if(_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF && _model.entitlementEnabled)
					_model.reportDataMap[_screenType].chartDp = _model.reportDataMap[_screenType].dimToChartDpMap["user_content_dropoff"];
				else
					_model.reportDataMap[_screenType].chartDp = _model.reportDataMap[_screenType].dimToChartDpMap["content_dropoff"];
			}	
			
			_model.selectedReportData = null; //refresh
			_model.selectedReportData = _model.reportDataMap[_screenType];	
		}
		
		
		/**
		 * Standrtizes values that should be presented in a different scale than what they are received from the server.
		 * @param value
		 * @param dimId
		 * 
		 */
		private function standartize(value:Number, dimId:String):Number
		{
			
			// Workaround for the minutes presentation - received as milliseconds from the server
			switch (dimId){
				case "added_msecs":
				case "total_msecs":
					return value / 60000;
					break;
				default:
					return value;
			}
		}
		
		private function createDimObject(id:String):Object{
			var dimLbl : String = ResourceManager.getInstance().getString('analytics',id);
			var dimObj : Object = new Object()
			dimObj.label = dimLbl;
			dimObj.data = id;
			
			return dimObj;
		}
		
		private function getBaseTotal(totalDim:String):Number
		{
			for each (var baseTotal:KalturaReportBaseTotal in _model.selectedReportData.baseTotals){
				if (baseTotal.id == totalDim){
					return parseFloat(baseTotal.data);
				}
			}
			return Number.NaN;
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
						JSGate.expired();
						return;
					}
					else
						Alert.show( (info as KalturaEvent).error.errorMsg , "Error");
				}
			}
		}
	}
}