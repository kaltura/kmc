package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reports.FormatReportParam;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.commands.report.ReportGetTable;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaReportInputFilter;
	import com.kaltura.vo.KalturaReportTable;

	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class GetTableCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		private var _executeReportHelper:ExecuteReportHelper = new ExecuteReportHelper();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingTableFlag = true;

			_executeReportHelper.reportSetupBeforeExecution();

			var krif:KalturaReportInputFilter = _executeReportHelper.createFilterFromCurrentReport();

			if (!_model.selectedReportData.pager) {
				_model.selectedReportData.pager = new KalturaFilterPager();
				_model.selectedReportData.pager.pageSize = 10;
				_model.selectedReportData.pager.pageIndex = 1;
			}

			var objectIds:String = '';
			if (_model.selectedEntry && (_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
										|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
										|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
										|| _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN 
										|| _model.currentScreenState == ScreenTypes.MAP_OVERLAY_DRILL_DOWN 
										|| _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}

			if ((event as ReportEvent).orderBy)
				_model.selectedReportData.orderBy = (event as ReportEvent).orderBy;

			var reportGetTable:ReportGetTable = new ReportGetTable((event as ReportEvent).reportType, krif, 
																	_model.selectedReportData.pager, 
																	_model.selectedReportData.orderBy, objectIds);
			reportGetTable.queued = false;
			reportGetTable.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetTable.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(reportGetTable);
		}


		public function result(result:Object):void {
			// set loading flags
			_model.loadingTableFlag = false;
			_model.checkLoading();
			
			var krt:KalturaReportTable = KalturaReportTable(result.data);

			// if no table data (empty table)
			if (krt && !krt.data) {
				// Atar: the commented part points to the same object as the uncommented. WTF?
				_model.selectedReportData.tableDp = /*_model.reportDataMap[_model.currentScreenState].tableDp = */ null;
				_model.selectedReportData.totalCount = /*_model.reportDataMap[_model.currentScreenState].totalCount = */ 0;
				
				_model.selectedReportData = null; //refreash
				_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
				return;
			}

			// spread received data through the model
			var tablesArr:Array = krt.data.split(";");
			var headersArr:Array = krt.header.split(",");

			var arrCol:ArrayCollection = new ArrayCollection();

			for (var i:int = 0; i < tablesArr.length; i++) {
				if (tablesArr[i]) {
					var propArr:Array = tablesArr[i].split(",");

					var obj:Object = new Object();
					for (var j:int = 0; j < propArr.length; j++) {
						propArr[j] = FormatReportParam.format(headersArr[j], propArr[j]);
						if (headersArr[j])
							obj[headersArr[j].toString()] = propArr[j];
					}

					arrCol.addItem(obj);
				}
			}

			if (_model.currentScreenState != ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN)
				_model.reportDataMap[_model.currentScreenState].dataFieldDp = headersArr = headersArr.slice(1, headersArr.length); //remove the entry_id
			else
				_model.reportDataMap[_model.currentScreenState].dataFieldDp = headersArr;

			_model.reportDataMap[_model.currentScreenState].tableDp = arrCol;
			_model.reportDataMap[_model.currentScreenState].totalCount = krt.totalCount;
			_model.filter = _model.filter;
			_model.selectedReportData = null; //refreash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
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