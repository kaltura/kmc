package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.ReportEvent;
	import com.kaltura.kmc.modules.analytics.model.KMCModelLocator;
	import com.kaltura.kmc.modules.analytics.model.reports.FormatReportParam;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.vo.AggregateDataVo;
	import com.kaltura.commands.report.ReportGetTotal;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaReportInputFilter;
	import com.kaltura.vo.KalturaReportTotal;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class GetTotalCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		private var _executeReportHelper : ExecuteReportHelper = new ExecuteReportHelper();
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;	
			_model.loadingTotalFlag = true;
			
			_executeReportHelper.reportSetupBeforeExecution();
			
			var krif : KalturaReportInputFilter = _executeReportHelper.createFilterFromCurrentReport();
			
			var objectIds : String = '';
			if(_model.selectedEntry &&  
				( _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF || 
				  _model.currentScreenState == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS ||
				  _model.currentScreenState == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.MAP_OVERLAY_DRILL_DOWN || 
				  _model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN) )
			{
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			
			var reportGetTotal : ReportGetTotal = new ReportGetTotal( (event as ReportEvent).reportType , krif , objectIds);
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