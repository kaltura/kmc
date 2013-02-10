package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetTable;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.reports.FormatReportParam;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaReportBaseTotal;
	import com.kaltura.vo.KalturaReportInputFilter;
	import com.kaltura.vo.KalturaReportTable;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class GetTableCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();

		private var _tableData:KalturaReportTable;
		private var _addTotals:Boolean;
		private var _baseTotalsWatcher:ChangeWatcher;
		private var _isDataPending:Boolean;
		private var _screenType:int;
		
		public function execute(event:CairngormEvent):void {
			// set load flags
			_model.loadingFlag = true;
			_model.loadingTableFlag = true;

			var reportEvt:ReportEvent = event as ReportEvent;
			_addTotals = reportEvt.addTableTotals;

			
			
			if (reportEvt.screenType != -1) {
				_screenType = reportEvt.screenType;
			}
			else {
				_screenType = _model.currentScreenState;
			}
			
			var selectedReportData:ReportData = _model.reportDataMap[_screenType] as ReportData;
			ExecuteReportHelper.reportSetupBeforeExecution();

			if (!selectedReportData.pager) {
				selectedReportData.pager = new KalturaFilterPager();
				selectedReportData.pager.pageSize = ReportData.DEF_PAGER_SIZE;
				selectedReportData.pager.pageIndex = 1;
			}

			// Workaround to the base total limitation
			if (_addTotals) {
				selectedReportData.pager.pageSize = 500;
			}

			var objectIds:String = '';
			if (_model.selectedEntry && (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS || _screenType == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || _screenType == ScreenTypes.MAP_OVERLAY_DRILL_DOWN || _screenType == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN || _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				objectIds = selectedReportData.objectIds = _model.selectedEntry;
			}

			if ((event as ReportEvent).orderBy)
				selectedReportData.orderBy = reportEvt.orderBy;

			var reportGetTable:ReportGetTable;
			//If we have a user report call we need to have another filter (that supports application and users) 
			//when we generate the report get total call
			if (_screenType == ScreenTypes.END_USER_ENGAGEMENT || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS || _screenType == ScreenTypes.END_USER_STORAGE || _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) {
				var keurif:KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen(_screenType));

				//in the reports above we need to send playback context instead of categories
//				keurif.playbackContext = keurif.categories;
//				keurif.categories = null;

				reportGetTable = new ReportGetTable(reportEvt.reportType, keurif,
					selectedReportData.pager,
					selectedReportData.orderBy, objectIds);
			}
			else {
				var krif:KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport(_model.getFilterForScreen(_screenType));
				reportGetTable = new ReportGetTable(reportEvt.reportType, krif,
					selectedReportData.pager,
					selectedReportData.orderBy, objectIds);
			}

			reportGetTable.queued = false;
			reportGetTable.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetTable.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(reportGetTable);
		}


		public function result(result:Object):void {
			// set loading flags
			_model.loadingTableFlag = false;
			_model.checkLoading();

			// save received data
			_tableData = KalturaReportTable(result.data);
			
			// add totals if required
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
		 * when an "added" column is followed by a "removed" column, add a "total" column
		 * @param headersArr
		 * @param totalCounters
		 * @return adjusted headers array
		 */
		private function addTotalsColumnHeaders(headersArr:Array, totalCounters:Object):Array {
			var currHeader:String;
			var tempHeaders:Array = new Array();
			
			// Searching for an "added..." column followed by a "deleted..." column, to add a "total..." column. 
			var currIndex:uint = 0;
			while (currIndex < headersArr.length) {
				currHeader = headersArr[currIndex] as String;
				tempHeaders.push(currHeader);
				
				var isTotal:Boolean = false;
				
				// Checking we're not checking the last index in the headers array.
				if (currIndex + 1 < headersArr.length) {
					var nextHeader:String = headersArr[currIndex + 1];
					
					// Checking for the right combination of columns
					if (currHeader.substr(0, 5) == "added" && nextHeader.substr(0, 7) == "deleted") {
						
						// Skipping the next index and already pushing the next header before the total header.
						currIndex += 2;
						tempHeaders.push(nextHeader);
						
						// Creating the total header and pushing it to the modified headers array
						isTotal = true;
						var totalHeader:String = "total" + currHeader.slice(5);
						totalCounters[totalHeader] = getBaseTotal(totalHeader);
						tempHeaders.push(totalHeader);
					}
				}
				
				// If no total header was created, going to the next header to check for a match.
				if (!isTotal) {
					currIndex += 1;
				}
			}
			return tempHeaders;
		}

		
		/**
		 * create table vo according to current headers 
		 * @param dataString	the data receved from server, comma separated string
		 * @param headersArr	list of table headers
		 * @param totalCounters	previously calculated totals values 
		 * @return data object
		 */
		private function createDataObject(dataString:String, headersArr:Array, totalCounters:Object):Object {
			var propArr:Array = dataString.split(","); // each element is a value in the line
			var currHeader:String;
			var obj:Object = new Object(); // obj is an object with table headers as keys and relevant values, it is actual table data
			var propCounter:int = 0;
			for (var j:int = 0; j < headersArr.length; j++) {
				currHeader = headersArr[j] as String;
				if ((_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN) 
					&& currHeader == 'unique_videos') {
					propCounter++;
					continue;
				}
				if (_addTotals && currHeader.indexOf("total") != -1) {
					// this is a "total" column
					// add previous deleted (negative) and added (positive) for the current total value.
					totalCounters[currHeader] += (parseFloat(propArr[propCounter - 1]) * -1) + parseFloat(propArr[propCounter - 2]);
					obj[currHeader] = FormatReportParam.format(currHeader, totalCounters[currHeader]);
				}
				else {
					// normal column
					obj[currHeader] = FormatReportParam.format(currHeader, propArr[propCounter]);
					propCounter++;
				}
			}
			return obj;
		}
		
		
		private function parseData():void {
			var reportData:ReportData = _model.reportDataMap[_screenType]; 
			// if no table data (empty table)
			if (_tableData && !_tableData.data) {
				reportData.tableDp = null;
				reportData.totalCount = 0;

				_model.selectedReportData = null; //refresh
				_model.selectedReportData = reportData;
				return;
			}

			// spread received data through the model
			var tablesArr:Array = _tableData.data.split(";"); // each array element is a line in the table (comma seperated values)
			var headersArr:Array = _tableData.header.split(","); // each array elememt is column header
			var originalHeaders:Array = headersArr.slice();

			var totalCounters:Object = new Object();
			if (_addTotals) {
				headersArr = addTotalsColumnHeaders(headersArr, totalCounters);
			}

			var arrCol:ArrayCollection = new ArrayCollection(); // table data provider

			for (var i:int = 0; i < tablesArr.length; i++) {
				if (tablesArr[i]) {
					var obj:Object = createDataObject(tablesArr[i], headersArr, totalCounters);
					arrCol.addItem(obj);
				}
			}
			
			reportData.tableDp = arrCol;

			// Patches for specific data removal
			if ((_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN) 
				&& headersArr.indexOf('unique_videos') != -1) {
				headersArr.splice(headersArr.indexOf('unique_videos'), 1);
			}

			// remove "id" header if required:
			// On some cases we have id that return from the server and we need to filter it 
			// for presentation without id as a table column but in some cases we want to show it
			if (_screenType != ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN 
				&& _screenType != ScreenTypes.END_USER_ENGAGEMENT 
				&& _screenType != ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN 
				&& _screenType != ScreenTypes.PARTNER_BANDWIDTH_AND_STORAGE 
				&& _screenType != ScreenTypes.END_USER_STORAGE_DRILL_DOWN 
				&& !(_model.entitlementEnabled && (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
												|| _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF
												|| _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS))) {
				reportData.dataFieldDp = headersArr = headersArr.slice(1, headersArr.length); //remove the entry_id
				reportData.originalTableHeaders = originalHeaders = originalHeaders.slice(1, originalHeaders.length); //remove the entry_id

				reportData.wasObjectIdDropped = true;
			}
			else {
				reportData.dataFieldDp = headersArr;
				reportData.originalTableHeaders = originalHeaders;
			}

			// set table totalcount
			if (_tableData.totalCount != int.MIN_VALUE && _tableData.totalCount != 0)
				reportData.totalCount = _tableData.totalCount;

			if (_addTotals) {
				_model.selectedReportData.pager.pageSize = arrCol.length;
			}
			
			_model.selectedReportData = null; //refresh
			_model.selectedReportData = reportData;
		}


		private function getBaseTotal(totalHeader:String):Number {
			for each (var baseTotal:KalturaReportBaseTotal in _model.selectedReportData.baseTotals) {
				if (baseTotal.id == totalHeader) {
					return parseFloat(baseTotal.data);
				}
			}
			return Number.NaN;
		}


		public function fault(info:Object):void {
			//resets selectedReportData to clean view
			_model.reportDataMap[_screenType].tableDp = null;
			_model.reportDataMap[_screenType].totalCount = 0;

			_model.selectedReportData = _model.reportDataMap[_screenType];
			
			_model.loadingTableFlag = false;
			_model.checkLoading();
		}
	}
}
