package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetTable;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
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

		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingTableFlag = true;

			_addTotals = (event as ReportEvent).addTableTotals;
			
			ExecuteReportHelper.reportSetupBeforeExecution();

			if (!_model.selectedReportData.pager) {
				_model.selectedReportData.pager = new KalturaFilterPager();
				_model.selectedReportData.pager.pageSize = 10;
				_model.selectedReportData.pager.pageIndex = 1;
			}
			
			// Workaround to the base total limitation
			if (_addTotals){
				_model.selectedReportData.pager.pageSize = 500;
			}

			var objectIds:String = '';
			if (_model.selectedEntry && (_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
										|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
										|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
										|| _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN 
										|| _model.currentScreenState == ScreenTypes.MAP_OVERLAY_DRILL_DOWN 
										|| _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN
										|| _model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN
										|| _model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}

			if ((event as ReportEvent).orderBy)
				_model.selectedReportData.orderBy = (event as ReportEvent).orderBy;

			var reportGetTable:ReportGetTable;
			//If we have a user report call we need to have another fileter (that support application and users) 
			//when we generate the report get total call
			if (_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT || 
				_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				_model.currentScreenState == ScreenTypes.END_USER_STORAGE || 
				_model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)
			{
				var keurif : KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport();
				
				//in the reports above we need to send playback context and instead of categories
				keurif.playbackContext = keurif.categories;
				keurif.categories = null;
				
				reportGetTable = new ReportGetTable((event as ReportEvent).reportType, keurif, 
					_model.selectedReportData.pager, 
					_model.selectedReportData.orderBy, objectIds);
			}
			else
			{
				var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport();
				reportGetTable = new ReportGetTable((event as ReportEvent).reportType, krif, 
					_model.selectedReportData.pager, 
					_model.selectedReportData.orderBy, objectIds);
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
			
			_tableData = KalturaReportTable(result.data);
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
			
			// if no table data (empty table)
			if (_tableData && !_tableData.data) {
				// Atar: the commented part points to the same object as the uncommented. WTF?
				_model.selectedReportData.tableDp = /*_model.reportDataMap[_model.currentScreenState].tableDp = */ null;
				_model.selectedReportData.totalCount = /*_model.reportDataMap[_model.currentScreenState].totalCount = */ 0;
				
				_model.selectedReportData = null; //refreash
				_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
				return;
			}

			// spread received data through the model
			var i:int;
			var tablesArr:Array = _tableData.data.split(";");
			var headersArr:Array = _tableData.header.split(",");
			
			var totalCounters:Object = new Object();
			if (_addTotals){
				var tempHeaders:Array = new Array();
				for each (var header:String in headersArr){
					tempHeaders.push(header);
					if (header.substr(0, 5) == "added"){
						var totalHeader:String = "total" + header.slice(5);
						totalCounters[totalHeader] = getBaseTotal(totalHeader);
						tempHeaders.push(totalHeader);
					}
				}
				headersArr = tempHeaders;
			}
			
			var arrCol:ArrayCollection = new ArrayCollection();
			
			for (i = 0; i < tablesArr.length; i++) {
				if (tablesArr[i]) {
					var propArr:Array = tablesArr[i].split(",");

					var obj:Object = new Object();
					var propCounter:int = 0;
					for (var j:int = 0; j < headersArr.length; j++) {
						var currHeader:String = headersArr[j] as String;
						if (_addTotals && currHeader.indexOf("total") != -1){
							totalCounters[currHeader] += parseFloat(propArr[propCounter - 1]);
							obj[currHeader] = FormatReportParam.format(currHeader, totalCounters[currHeader]);
						} else {
//							if (headersArr[j])
							obj[currHeader] = FormatReportParam.format(currHeader, propArr[propCounter]);
							propCounter++;
						}
					}

					arrCol.addItem(obj);
					
					
				}
			}

			//On some cases we have id that return from the server and we need to filter it 
			//for presentation without id as a table column but in some cases we want to show it
			if (_model.currentScreenState != ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN
				&& _model.currentScreenState != ScreenTypes.END_USER_ENGAGEMENT
				&& _model.currentScreenState != ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN
				&& _model.currentScreenState != ScreenTypes.PARTNER_BANDWIDTH_AND_STORAGE
				&& _model.currentScreenState != ScreenTypes.END_USER_STORAGE_DRILL_DOWN
				&& ! ( _model.entitlementEnabled 
					 && ( _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT
					 	  || _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF
					 	  || _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS)
					)
				)
			{
				_model.reportDataMap[_model.currentScreenState].dataFieldDp = headersArr = headersArr.slice(1, headersArr.length); //remove the entry_id
				_model.reportDataMap[_model.currentScreenState].wasObjectIdDropped = true;
			}
			else
			{
				_model.reportDataMap[_model.currentScreenState].dataFieldDp = headersArr;
			}
			
			_model.reportDataMap[_model.currentScreenState].tableDp = arrCol;
			
			if(_tableData.totalCount != int.MIN_VALUE)
				_model.reportDataMap[_model.currentScreenState].totalCount = _tableData.totalCount;
			
			if (_addTotals){
				_model.selectedReportData.pager.pageSize = arrCol.length;
			}
			_model.filter = _model.filter;
			_model.selectedReportData = null; //refreash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
		}
		
		private function getBaseTotal(totalHeader:String):Number
		{
			for each (var baseTotal:KalturaReportBaseTotal in _model.selectedReportData.baseTotals){
				if (baseTotal.id == totalHeader){
					return parseFloat(baseTotal.data);
				}
			}
			return Number.NaN;
		}

		public function fault(info:Object):void {
			//resets selectedReportData to clean view
			_model.selectedReportData.tableDp = _model.reportDataMap[_model.currentScreenState].tableDp = null;
			_model.selectedReportData.totalCount = _model.reportDataMap[_model.currentScreenState].totalCount = 0;

			_model.loadingTableFlag = false;
			_model.checkLoading();
		}
	}
}