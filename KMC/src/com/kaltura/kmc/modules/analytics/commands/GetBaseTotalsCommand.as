package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetBaseTotal;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaReportBaseTotal;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class GetBaseTotalsCommand implements ICommand, IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			_model.loadingBaseTotals = true;
			
			
			// reset base totals info
			_model.selectedReportData.baseTotals = null;
			
			if (!_model.selectedReportData.pager) {
				_model.selectedReportData.pager = new KalturaFilterPager();
				_model.selectedReportData.pager.pageSize = ReportData.DEF_PAGER_SIZE;
				_model.selectedReportData.pager.pageIndex = 1;
			}
			
			var objectIds:String = '';
			if (_model.selectedEntry && _model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var filter:KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen((event as ReportEvent).screenType));
			filter.playbackContext = filter.categories;
			filter.categories = null;
			
			var getBaseTotals:ReportGetBaseTotal = new ReportGetBaseTotal((event as ReportEvent).reportType, filter, objectIds);
			getBaseTotals.queued = false;
			getBaseTotals.addEventListener(KalturaEvent.COMPLETE, result);
			getBaseTotals.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(getBaseTotals);
		}
		
		public function result(data:Object):void
		{
			_model.selectedReportData.baseTotals = data.data as Array;
			_model.loadingBaseTotals = false;
			_model.checkLoading();
		}
		
		
		public function fault(info:Object):void
		{
			// Clearing totals data
			_model.selectedReportData.baseTotals = null;
			
			_model.loadingBaseTotals = false;
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