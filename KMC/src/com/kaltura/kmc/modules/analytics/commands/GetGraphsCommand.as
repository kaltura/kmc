package com.kaltura.kmc.modules.analytics.commands {
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
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetGraphsCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();

		private var _addTotals:Boolean;

		private var _graphDataArr:Array;
		private var _baseTotalsWatcher:ChangeWatcher;
		private var _isDataPending:Boolean;

		private var _screenType:int;


		/**
		 * will execute the request to get all the graph results accourding to the current filter
		 * @param event (ReportEvent)
		 *
		 */
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingChartFlag = true;

			_addTotals = (event as ReportEvent).addGraphTotals;

			ExecuteReportHelper.reportSetupBeforeExecution();

			var reportEvent:ReportEvent = event as ReportEvent;
			if (reportEvent.screenType != -1) {
				_screenType = reportEvent.screenType;
			}
			else {
				_screenType = _model.currentScreenState;
			}

			var objectIds:String = '';
			if (_model.selectedEntry && (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS || _screenType == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || _screenType == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN || _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}

			var reportGetGraphs:ReportGetGraphs;
			//If we have a user report call we need to have another filter (that support application and users) 
			//when we generate the report get total call
			if (_screenType == ScreenTypes.END_USER_ENGAGEMENT || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS || _screenType == ScreenTypes.END_USER_STORAGE || _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) {
				var keurif:KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen(_screenType));

				//in the reports above we need to send playback context instead of categories
//				keurif.playbackContext = keurif.categories;
//				keurif.categories = null;

				reportGetGraphs = new ReportGetGraphs((event as ReportEvent).reportType, keurif, _model.selectedReportData.selectedDim, objectIds);
			}
			else {
				var krif:KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport(_model.getFilterForScreen(_screenType));
				reportGetGraphs = new ReportGetGraphs((event as ReportEvent).reportType, krif, _model.selectedReportData.selectedDim, objectIds);
			}

			reportGetGraphs.queued = false;
			reportGetGraphs.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetGraphs.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(reportGetGraphs);
		}


		public function result(result:Object):void {
			_model.loadingChartFlag = false;
			_model.checkLoading();

			_graphDataArr = result.data as Array;

			if (_addTotals && _model.loadingBaseTotals) {
				if (_baseTotalsWatcher) {
					_baseTotalsWatcher.unwatch();
				}
				_baseTotalsWatcher = BindingUtils.bindSetter(onBaseTotalsLoaded, _model, ["selectedReportData", "baseTotals"]);
				_isDataPending = true;
			}
			else {
				parseData();
			}
		}


		private function onBaseTotalsLoaded(data:Object):void {
			if (data != null) {
				if (_baseTotalsWatcher) {
					_baseTotalsWatcher.unwatch();
					_baseTotalsWatcher = null;
				}
				if (_isDataPending) {
					_isDataPending = false;
					parseData();
				}
			}
		}


		/**
		 * uses data previously saved in <code>_graphDataArr</code>.
		 * (a) create dimArrColl and populate with received reports, add totals if required.
		 * (b) normalize poits data and set them in dimToChartDpMap (by report id key)
		 */
		private function parseData():void {
			var reportData:ReportData = _model.reportDataMap[_screenType]; 
			
			reportData.dimToChartDpMap = new Object();
			reportData.dimArrColl = new ArrayCollection();

			var initDim:String = null; // initial dimension of the graph 
			var krp:KalturaReportGraph;
			for (var i:int = 0; i < _graphDataArr.length; i++) {
				krp = _graphDataArr[i] as KalturaReportGraph;

				reportData.dimArrColl.addItem(createDimObject(krp.id));
				
				// use the first received report as default graph dimension
				if (!initDim)
					initDim = krp.id;

				// for totals calculation
				var totalPoints:ArrayCollection;
				var totalCounter:Number;

				if (_addTotals && krp.id.substr(0, 5) == "added") {
					// add graph dimension for relevant "total"
					totalPoints = new ArrayCollection();
					var totalDimName:String = "total" + krp.id.slice(5);
					totalCounter = getBaseTotal(totalDimName);
					var totalDimObj:Object = createDimObject(totalDimName);
					reportData.dimArrColl.addItem(totalDimObj);
				}
				
				
				var pointsArr:Array = krp.data.split(";");	// each element is string: x,y
				var graphPoints:ArrayCollection = new ArrayCollection();

				for (var j:int = 0; j < pointsArr.length; j++) {
					if (pointsArr[j]) {
						var xYArr:Array = pointsArr[j].split(",");
						// get y value as float
						var yVal:Number = parseFloat(xYArr[1]);
						// if that didn't work, use "0"
						yVal = isNaN(yVal) ? 0 : yVal;
						
						var obj:Object = new Object();
						if (_screenType == ScreenTypes.CONTENT_DROPOFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF) {
							// content dropoff reports
							obj.x = ResourceManager.getInstance().getString('analytics', xYArr[0]);
							obj.y = yVal;
						}
						else if (String(xYArr[0]).length == 8) {
							// For full dates (i.e, 20130112), create a Date from given values and use its timestamp
							var date:Date;
							var year:String = String(xYArr[0]).substring(0, 4);
							var month:String = String(xYArr[0]).substring(4, 6);
							var day:String = String(xYArr[0]).substring(6, 8);
							date = new Date(Number(year), Number(month) - 1, Number(day));
							var timestamp:Number = date.time;
							
							obj.x = timestamp;
							obj.y = standartize(yVal, krp.id);
							
							if (_addTotals && krp.id.substr(0, 5) == "added") {
								totalCounter += yVal;
								totalPoints.addItem({x: timestamp, y: standartize(totalCounter, totalDimName)});
							}
						}
						else {
							obj.x = xYArr[0];
							obj.y = standartize(yVal, krp.id);
							
							if (_addTotals && krp.id.substr(0, 5) == "added") {
								totalCounter += yVal;
								totalPoints.addItem({x: xYArr[0], y: standartize(totalCounter, totalDimName)});
							}
						}
						graphPoints.addItem(obj);
					}
				}

				reportData.dimToChartDpMap[krp.id] = graphPoints;

				if (_addTotals && krp.id.substr(0, 5) == "added") {
					reportData.dimToChartDpMap[totalDimName] = totalPoints;
				}

				if (!reportData.selectedDim && i == 0)
					reportData.selectedDim = _graphDataArr[i].id;
			}
			
			// set chart DP
			setChartDp(reportData, initDim);

			_model.selectedReportData = null; //refresh
			_model.selectedReportData = reportData;
		}
		

		/**
		 * sets the initial dataprovider for the chart 
		 * @param reportData	report data to mutate
		 * @param defaultDimension
		 */		
		private function setChartDp(reportData:ReportData, defaultDimension:String):void {
			if (_screenType == ScreenTypes.CONTENT_DROPOFF) {
				reportData.chartDp = reportData.dimToChartDpMap["content_dropoff"];
			}
			else if (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF) {
				if (_model.entitlementEnabled)
					reportData.chartDp = reportData.dimToChartDpMap["user_content_dropoff"];
				else
					reportData.chartDp = reportData.dimToChartDpMap["content_dropoff"];
			}
			else {
				if (reportData.selectedDim)
					reportData.chartDp = reportData.dimToChartDpMap[reportData.selectedDim];
				else
					reportData.chartDp = reportData.dimToChartDpMap[defaultDimension];
			}
		}

		/**
		 * Standrtizes values that should be presented in a different scale than what they are received from the server.
		 * @param value value as recieved from server
		 * @param dimId	key by which we can convert value to different units
		 * @return value in new units
		 */
		private function standartize(value:Number, dimId:String):Number {
			// Workaround for the minutes presentation - received as milliseconds from the server
			switch (dimId) {
				case "added_msecs":
				case "total_msecs":
					return value / 60000;
					break;
				default:
					return value;
			}
		}


		/**
		 * get an object representing the dimension
		 * @param id dimension id
		 * @return {label: resource manager value for the dimesion, data: dimension id}
		 */
		private function createDimObject(id:String):Object {
			var dimObj:Object = new Object();
			dimObj.label = ResourceManager.getInstance().getString('analytics', id);
			dimObj.data = id;
			return dimObj;
		}


		private function getBaseTotal(totalDim:String):Number {
			for each (var baseTotal:KalturaReportBaseTotal in _model.selectedReportData.baseTotals) {
				if (baseTotal.id == totalDim) {
					return parseFloat(baseTotal.data);
				}
			}
			return Number.NaN;
		}


		public function fault(info:Object):void {
			_model.reportDataMap[_model.currentScreenState].chartDp = null;
			if (_model.selectedReportData)
				_model.selectedReportData.chartDp = null;

			_model.loadingChartFlag = false;
			_model.checkLoading();

			if ((info as KalturaEvent).error) {
				if ((info as KalturaEvent).error.errorMsg) {
					if ((info as KalturaEvent).error.errorMsg.substr(0, 10) == "Invalid KS") {
						JSGate.expired();
						return;
					}
					else
						Alert.show((info as KalturaEvent).error.errorMsg, "Error");
				}
			}
		}
	}
}
