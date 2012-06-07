package com.kaltura.kmc.modules.analytics.commands
{
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

	public class GetTotalCommand implements ICommand, IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;	
			_model.loadingTotalFlag = true;
			
			var objectIds : String = '';
			if(_model.selectedEntry &&  
				( _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				  _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.MAP_OVERLAY_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN ||
				  _model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN) )
			{
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var reportGetTotal : ReportGetTotal;
			//If we have a user report call we need to have another fileter (that support application and users) 
			//when we generate the report get total call
			if ( _model.entitlementEnabled &&
				(_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT || 
				_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF ||
				_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				_model.currentScreenState == ScreenTypes.END_USER_STORAGE ||
				_model.currentScreenState == ScreenTypes.END_USER_STORAGE_DRILL_DOWN))
			{
				var keurif : KalturaEndUserReportInputFilter = ExecuteReportHelper.createEndUserFilterFromCurrentReport();
				
				//in the reports above we need to send playback context and instead of categories
				keurif.playbackContext = keurif.categories;
				keurif.categories = null;
				
				reportGetTotal = new ReportGetTotal( (event as ReportEvent).reportType , keurif , objectIds);
			}
			else
			{
				var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport();
				reportGetTotal = new ReportGetTotal( (event as ReportEvent).reportType , krif , objectIds);
			}
			
			reportGetTotal.queued = false;
			reportGetTotal.addEventListener( KalturaEvent.COMPLETE , result );
			reportGetTotal.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( reportGetTotal );
		}
		
		public function result( result:Object ):void
		{
			_model.loadingTotalFlag = false;
			_model.checkLoading();
			var krt : KalturaReportTotal = KalturaReportTotal( result.data );
			
			var aggArr : Array = krt.data.split(',');
			var aggLbls : Array = krt.header.split(',');
			var arrCol : ArrayCollection = new ArrayCollection();
			for(var i:int=0; i<aggArr.length; i++)
			{
				var aggDataVo : AggregateDataVo = new AggregateDataVo();
				aggDataVo.title = ResourceManager.getInstance().getString('analytics',aggLbls[i]);
				aggDataVo.value = FormatReportParam.format( aggLbls[i] , aggArr[i] );
				aggDataVo.helpToolTip =ResourceManager.getInstance().getString('analytics',aggLbls[i]+"ToolTip");
				arrCol.addItem( aggDataVo );
			}
			
			//if this is drill down so set the saved nameto the ReportData Object
			if(_model.drillDownName)
				_model.reportDataMap[_model.currentScreenState].objectName = _model.drillDownName; 
				
			_model.reportDataMap[_model.currentScreenState].aggregatedDataArrCol = arrCol;
			_model.filter = _model.filter;
			
			//if we have entitlement and the uniqe users are known
			if ( _model.entitlementEnabled &&
				(_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT || 
					_model.currentScreenState == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN ||
					_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT ||
					_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF ||
					_model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ))
			{
				//if we recive the number of uniqe users set the pager to this page size
				if(arrCol[0] != '-')
					_model.selectedReportData.totalCount = int(arrCol[0].value);
			}
			
			_model.selectedReportData = null; //refreash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
		}
		
		public function fault(info:Object):void
		{
			//resets selectedReportData to clean view
			_model.reportDataMap[_model.currentScreenState].aggregatedDataArrCol = null;
			if(_model.selectedReportData)
				_model.selectedReportData.aggregatedDataArrCol = null;

			_model.loadingTotalFlag = false;
			_model.checkLoading();
		}
	}
}