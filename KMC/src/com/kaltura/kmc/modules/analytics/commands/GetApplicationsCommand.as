package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetTable;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reports.FormatReportParam;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.types.KalturaReportType;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaReportInputFilter;
	import com.kaltura.vo.KalturaReportTable;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetApplicationsCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingApplicationsFlag = true;

			ExecuteReportHelper.reportSetupBeforeExecution();

			var applicationPager : KalturaFilterPager = new KalturaFilterPager();
			applicationPager.pageSize = 10000;
			applicationPager.pageIndex = 1;
	
			var reportGetTable:ReportGetTable;

			var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport();
			reportGetTable = new ReportGetTable(KalturaReportType.APPLICATIONS,
												krif, 
												applicationPager);
			 
			reportGetTable.queued = false;
			reportGetTable.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetTable.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(reportGetTable);
		}


		public function result(result:Object):void {
			// set loading flags
			_model.loadingApplicationsFlag = false;
			_model.checkLoading();
			
			var krt:KalturaReportTable = KalturaReportTable(result.data);

			// spread received data through the model
			var tablesArr:Array;
			var arrCol:ArrayCollection;
			if(krt.data)
			{
				tablesArr = krt.data.split(";");
				arrCol = new ArrayCollection(tablesArr);
							
				//add all as the first item in the list
				arrCol.addItemAt(ResourceManager.getInstance().getString('analytics', 'all'),0);
				_model.applicationsList = arrCol;
			}
			else
			{
				tablesArr = new Array();
				tablesArr.push(ResourceManager.getInstance().getString('analytics', 'all'));
				arrCol = new ArrayCollection(tablesArr);
				_model.applicationsList = arrCol;
			}
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