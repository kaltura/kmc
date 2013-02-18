package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.report.ReportGetTotal;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reports.FormatReportParam;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.vo.AggregateDataVo;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaReportInputFilter;
	import com.kaltura.vo.KalturaReportTotal;

	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;

	public class GetTotalCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		private var _screenType:int;


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingTotalFlag = true;

			var reportEvent:ReportEvent = event as ReportEvent;

			if (reportEvent.screenType != -1) {
				_screenType = reportEvent.screenType;
			}
			else {
				_screenType = _model.currentScreenState;
			}

			var objectIds:String = '';
			if (_model.selectedEntry && (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
					|| _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
					|| _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
					|| _screenType == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN 
					|| _screenType == ScreenTypes.MAP_OVERLAY_DRILL_DOWN 
					|| _screenType == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN 
					|| _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN
					|| _screenType == ScreenTypes.PLATFORM_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}

			var reportGetTotal:ReportGetTotal;
			//If we have a user report call we need to have another filter (that support application and users) 
			//when we generate the report get total call
			if (_model.entitlementEnabled && (_screenType == ScreenTypes.END_USER_ENGAGEMENT || _screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS || _screenType == ScreenTypes.END_USER_STORAGE || _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				var keurif:KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen(_screenType));

				//in the reports above we need to send playback context and instead of categories
//				keurif.playbackContext = keurif.categories;
//				keurif.categories = null;

				reportGetTotal = new ReportGetTotal((event as ReportEvent).reportType, keurif, objectIds);
			}
			else {
				var krif:KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport(_model.getFilterForScreen(_screenType));
				reportGetTotal = new ReportGetTotal((event as ReportEvent).reportType, krif, objectIds);
			}

			reportGetTotal.queued = false;
			reportGetTotal.addEventListener(KalturaEvent.COMPLETE, result);
			reportGetTotal.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(reportGetTotal);
		}


		public function result(result:Object):void {
			_model.loadingTotalFlag = false;
			_model.checkLoading();
			var reportData:ReportData = _model.reportDataMap[_screenType];
			var krt:KalturaReportTotal = KalturaReportTotal(result.data);

			var aggArr:Array = krt.data.split(',');
			var aggLbls:Array = krt.header.split(',');
			var arrCol:ArrayCollection = new ArrayCollection();
			for (var i:int = 0; i < aggArr.length; i++) {
				// Patches for data removal
				if (_screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT && aggLbls[i] == 'unique_videos') {
					continue;
				}
				if (_screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN && aggLbls[i] == 'unique_known_users') {
					continue;
				}

				var aggDataVo:AggregateDataVo = new AggregateDataVo();
				aggDataVo.title = ResourceManager.getInstance().getString('analytics', aggLbls[i]);
				aggDataVo.formattedValue = FormatReportParam.format(aggLbls[i], aggArr[i]);
				aggDataVo.value = aggArr[i];
				if (_model.entitlementEnabled && _screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) {
					aggDataVo.helpToolTip = ResourceManager.getInstance().getString('analytics', "user_" + aggLbls[i] + "ToolTip");
				}
				else {
					aggDataVo.helpToolTip = ResourceManager.getInstance().getString('analytics', aggLbls[i] + "ToolTip");
				}
				arrCol.addItem(aggDataVo);
			}

			//if this is drill down so set the saved name to the ReportData Object
			if (_model.drillDownName)
				reportData.objectName = _model.drillDownName;

			reportData.aggregatedData = arrCol;
			reportData.originalTotalHeaders = aggLbls;

			//if we have entitlement and the unique users are known
			if (_model.entitlementEnabled && (_screenType == ScreenTypes.END_USER_ENGAGEMENT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || _screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS)) {
				//if we recive the number of uniqe users set the pager to this page size
				if (arrCol[0] != '-')
					_model.selectedReportData.totalCount = int(arrCol[0].value);
			}

			_model.selectedReportData = null; //refresh
			_model.selectedReportData = reportData;
		}


		public function fault(info:Object):void {
			//resets selectedReportData to clean view
			_model.reportDataMap[_screenType].aggregatedData = null;
			if (_model.selectedReportData)
				_model.selectedReportData.aggregatedData = null;

			_model.loadingTotalFlag = false;
			_model.checkLoading();
		}
	}
}
