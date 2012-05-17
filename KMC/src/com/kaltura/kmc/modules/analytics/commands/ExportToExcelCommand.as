package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.view.core.FileManager;
	import com.kaltura.commands.report.ReportGetUrlForReportAsCsv;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ExportToExcelCommand implements ICommand, IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		private var fm : FileManager = new FileManager();
		private var _fileUrl : String = "";
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			var headers : String = "";
			
			for(var j:int=0;j<_model.selectedReportData.totalHeaders.length; j++)
				if(_model.selectedReportData.totalHeaders[j] != "object_id")
					headers += ResourceManager.getInstance().getString('analytics',_model.selectedReportData.totalHeaders[j]) + ",";
					
			headers = headers.substr(0,headers.length-1);
			headers += ";";	//";Object Id,"; (see mantis ticket 13090 requesting to remove this header)
			
			if(_model.selectedReportData.tableHeaders)
			{
				for(var i:int=0;i<_model.selectedReportData.tableHeaders.length; i++)
					if(_model.selectedReportData.tableHeaders[i] != "object_id")
						headers +=  ResourceManager.getInstance().getString('analytics',_model.selectedReportData.tableHeaders[i]) + ",";
			}
			else
			{
				headers = "No Table";
			}
			
			headers = headers.substr(0,headers.length-1);
			
			var krif : KalturaReportInputFilter = ExecuteReportHelper.createFilterFromCurrentReport();
			
			//NEVER SHOULD HAPPEN BUT IF DOES THEN IT'S BETTER THEN FAIL SENDING MASSAGE
			if( _model.selectedReportData.message == "" ) _model.selectedReportData.message="no message"; 
			if( _model.selectedReportData.title == "" ) _model.selectedReportData.title="no title"; 
			
			var export2Csv : ReportGetUrlForReportAsCsv = new ReportGetUrlForReportAsCsv( _model.selectedReportData.title, 
																						  _model.selectedReportData.message,
																						  headers,
																						  _model.selectedReportData.type,
																						  krif,
																						  _model.selectedReportData.selectedDim,
																						  _model.selectedReportData.pager,
																						  _model.selectedReportData.orderBy,
																						  _model.selectedReportData.objectIds);									 
			export2Csv.addEventListener( KalturaEvent.COMPLETE , result );
			export2Csv.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( export2Csv );
			//fm.downloadFile("http://www.qed.co.il/examples/epgae/test.flv",'test','test');
		}
		
		public function result(result:Object):void
		{
			_model.loadingFlag = false;
			_fileUrl = result.data;
			Alert.show(  ResourceManager.getInstance().getString('analytics','csvReady') ,
						 ResourceManager.getInstance().getString('analytics','csvReadyTitle') ,
						 Alert.OK ,
						 null,
						 onClose );	
		}
		
		private function onClose( event : CloseEvent ) : void
		{
			fm.downloadFile( _fileUrl,
							 ResourceManager.getInstance().getString('analytics','downloadCSVTitle'), 
							 _model.selectedReportData.title +".csv");
		}
		
		public function fault(info:Object):void
		{
			//_model.loadingFlag = false;
		}	
	}
}