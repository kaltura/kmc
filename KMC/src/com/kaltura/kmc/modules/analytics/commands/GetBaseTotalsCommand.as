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
//		private var _addTableTotals:Boolean = false;
//		private var _graphWatcher:ChangeWatcher;
//		private var _tableWatcher:ChangeWatcher;
		
		public function GetBaseTotalsCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			_model.loadingBaseTotals = true;
			
//			_addTableTotals = (event as ReportEvent).addTableTotals;
			
			if (!_model.selectedReportData.pager) {
				_model.selectedReportData.pager = new KalturaFilterPager();
				_model.selectedReportData.pager.pageSize = ReportData.DEF_PAGER_SIZE;
				_model.selectedReportData.pager.pageIndex = 1;
			}
			
			var objectIds:String = '';
			if (_model.selectedEntry && (/*_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
				|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
				|| _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
				|| _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN 
				|| _model.currentScreenState == ScreenTypes.MAP_OVERLAY_DRILL_DOWN 
				|| _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN
				|| _model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN
				||*/ _model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var filter:KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport();
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
			_model.loadingBaseTotals = false;
			_model.checkLoading();
			
			_model.selectedReportData.baseTotals = data.data as Array;
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