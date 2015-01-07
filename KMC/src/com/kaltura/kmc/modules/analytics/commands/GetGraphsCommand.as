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

			var krif:KalturaReportInputFilter = ExecuteReportHelper.createFilterFromReport(_model.getFilterForScreen(_screenType), _screenType);
			var reportGetGraphs:ReportGetGraphs = new ReportGetGraphs((event as ReportEvent).reportType,
																		krif,
																		_model.selectedReportData.selectedDim,
																		ExecuteReportHelper.getObjectIds(_screenType));

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
		 * (b) normalize points data and set them in dimToChartDpMap (by report id key)
		 */
		private function parseData():void {
			var reportData:ReportData = _model.reportDataMap[_screenType];

			reportData.dimToChartDpMap = new Object();
			reportData.dimArrColl = new ArrayCollection();

			var krp:KalturaReportGraph;
			for (var i:int = 0; i < _graphDataArr.length; i++) {
				parseSingleReport(_graphDataArr[i] as KalturaReportGraph, reportData);
			}

			var initDim:String = null; // initial dimension of the graph 
			// use the first received report as default graph dimension
			if (_graphDataArr.length > 0)
				initDim = (_graphDataArr[0] as KalturaReportGraph).id;

			// set chart DP
			setChartDp(reportData, initDim);

			_model.selectedReportData = null; //refresh
			_model.selectedReportData = reportData;
		}


		private function parseSingleReport(krp:KalturaReportGraph, reportData:ReportData):void {
			var obj:Object;
			var j:int;
			var addTotalsReport:Boolean = _addTotals && krp.id.substr(0, 5) == "added"; // this report should be followed by a "totals" report
			var deductTotalsReport:Boolean = _addTotals && krp.id.substr(0, 7) == "deleted"; // this report should be considered in the "totals" report
			/*
			 *	in deleted_x report we assume the added_x already created 
			 *	the totals report, and we will only update it. 
			*/
			// for totals calculation
			var totalsGraphPoints:ArrayCollection; // points for totals graph
			var totalsSum:Number; // sums up y values

			reportData.dimArrColl.addItem(createDimObject(krp.id));
			if (!reportData.selectedDim)
				reportData.selectedDim = krp.id;

			
			var totalDimName:String;
			if (addTotalsReport) {
				// add graph dimension for relevant "total"
				totalsGraphPoints = new ArrayCollection();
				totalDimName = "total" + krp.id.slice(5); // remove "added" from id
				totalsSum = getBaseTotal(totalDimName);
				var totalDimObj:Object = createDimObject(totalDimName);
				reportData.dimArrColl.addItem(totalDimObj);
			}
			else if (deductTotalsReport) {
				totalsGraphPoints = new ArrayCollection();
				totalsSum = 0;
				totalDimName = "total" + krp.id.slice(7);	// remove "deleted" from id
			}

			var pointsArr:Array = krp.data.split(";"); // each element is string: x,y
			var graphPoints:ArrayCollection = new ArrayCollection();

			if (_screenType == ScreenTypes.PLATFORM) {
				// multiple lines in graph, need to save chartHeaders and create complex vo 
				var chartHeadersObj:Object = {}; // for multiple lines graph
				for (j = 0; j < pointsArr.length; j++) {
					if (pointsArr[j]) {
						var xyArr:Array = pointsArr[j].split(","); // [x, propName1:propVal1, propName2:propVal2, ..] 
						obj = new Object();
						obj.x = getTimeStampFromString(xyArr[0]);
						for (var k:int = 1; k < xyArr.length; k++) {
							// get prop names and values
							var yValAr:Array = xyArr[k].split(":"); // [propName, propValue] 
							obj[yValAr[0]] = yValAr[1];

							// set prop name on chartHeaders to true, to know it exists
							chartHeadersObj[yValAr[0]] = true;
						}
						graphPoints.addItem(obj);
					}
				}
				var chartHeaders:Array = [];
				for (var str:String in chartHeadersObj) {
					chartHeaders.push(str);
				}
				reportData.dimToChartHeadersMap[krp.id] = chartHeaders;
			}
			else {
				// single line graphs
				for (j = 0; j < pointsArr.length; j++) {
					if (pointsArr[j]) {
						var xYArr:Array = pointsArr[j].split(",");
						// get y value as float
						var yVal:Number = parseFloat(xYArr[1]);
						// if that didn't work, use "0"
						yVal = isNaN(yVal) ? 0 : yVal;
						obj = new Object();
						if (_screenType == ScreenTypes.CONTENT_DROPOFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF) {
							// content dropoff reports, bar charts with texts
							obj.x = ResourceManager.getInstance().getString('analytics', xYArr[0]);
							obj.y = yVal;
						}
						else if (_screenType == ScreenTypes.LIVE_CONTENT) {
							// 10 digit string - probably a date-time like 1979011510 (YYYYMMDDHH)
							obj = generateFullDateVo(String(xYArr[0]), yVal, krp.id);
						}
						else {
							if (String(xYArr[0]).length == 8 && !isNaN(parseInt(xYArr[0]))) {
								// 8 digit string - probably a date like 19790115
								obj = generateFullDateVo(String(xYArr[0]), yVal, krp.id);
							}
							else {
								obj.x = xYArr[0];
								obj.y = standartize(yVal, krp.id);

							}

							if (addTotalsReport || deductTotalsReport) {
								totalsSum += yVal;
								totalsGraphPoints.addItem({x: obj.x, y: standartize(totalsSum, totalDimName)});
							}
						}
						graphPoints.addItem(obj);
					}
				}

				if (addTotalsReport) {
					reportData.dimToChartDpMap[totalDimName] = totalsGraphPoints;
				}
				else if (deductTotalsReport) {
					// update added_totals data
					var totals:ArrayCollection = reportData.dimToChartDpMap[totalDimName] as ArrayCollection;
					j = 0;	// deleted index
					for (var i:int = 0; i<totals.length; i++) {
						if (j<totalsGraphPoints.length-1 && totals[i].x >= totalsGraphPoints[j+1].x) {
							j++;
						}
						totals[i].y -= totalsGraphPoints[j].y;
					}
				}
			}

			reportData.dimToChartDpMap[krp.id] = graphPoints;
		}


		/**
		 * For full dates (i.e, 20130112), create a Date from given values and use its timestamp
		 * @param xVal	the string that represents the date to be used as x value
		 * @param yVal	 parsed number to be y value
		 * @param krpid	report id by which we standardize y value
		 * @return data vo
		 */
		private function generateFullDateVo(xVal:String, yVal:Number, krpid:String):Object {
			return {x: getTimeStampFromString(xVal), y: standartize(yVal, krpid)};
		}


		/**
		 * @param sdate	a string that represents a date (i.e, 20130112)
		 * @param includeHours	if true, digits 9-10 are expected to be hours
		 * @return timestamp for the given date
		 */
		private function getTimeStampFromString(sdate:String, includeHours:Boolean = true):Number {
			var year:String = sdate.substring(0, 4);
			var month:String = sdate.substring(4, 6);
			var day:String = sdate.substring(6, 8);
			var hours:String = '0';
			if (includeHours) {
				hours = sdate.substring(8, 10);
			}
			var date:Date = new Date(Number(year), Number(month) - 1, Number(day), Number(hours));
			return date.time;
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
				if (reportData.selectedDim) {
					reportData.chartDp = reportData.dimToChartDpMap[reportData.selectedDim];
					reportData.selectedChartHeaders = reportData.dimToChartHeadersMap[reportData.selectedDim];
				}
				else {
					reportData.chartDp = reportData.dimToChartDpMap[defaultDimension];
					reportData.selectedChartHeaders = reportData.dimToChartHeadersMap[defaultDimension];
				}
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


		/**
		 * retreive base total value from model
		 * @param totalDim	 dimension for which we want the total
		 * @return base total value
		 */
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
