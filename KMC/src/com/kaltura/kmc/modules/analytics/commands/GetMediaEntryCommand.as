package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.control.DrillDownEvent;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.commands.baseEntry.BaseEntryGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaMixEntry;
	
	import mx.rpc.IResponder;

	public class GetMediaEntryCommand implements ICommand, IResponder
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			//get Entry
			_model.loadingFlag = true;
			_model.loadingEntryFlag = true;
			
			if(_model.reportDataMap[_model.currentScreenState].seletedMediaEntry)
				_model.reportDataMap[_model.currentScreenState].seletedMediaEntry = null;
				
			var baseEntryGet : BaseEntryGet = new BaseEntryGet( (event as DrillDownEvent).entryId );
			baseEntryGet.addEventListener( KalturaEvent.COMPLETE , result );
			baseEntryGet.addEventListener( KalturaEvent.FAILED , fault );
			_model.kc.post( baseEntryGet );
		}
		
		public function result(result:Object):void
		{
			_model.loadingEntryFlag = false;
			_model.checkLoading();
			
			var kme : KalturaBaseEntry; 
			
			if( result.data is KalturaMediaEntry )
				 kme = (result.data as KalturaMediaEntry);
			else if( result.data is KalturaMixEntry )
				 kme = (result.data as KalturaMixEntry);
			else
				kme = result.data;

			_model.reportDataMap[_model.currentScreenState].seletedMediaEntry = kme;
			_model.selectedReportData = null; //refrash
			_model.selectedReportData = _model.reportDataMap[_model.currentScreenState];
		}
		
		public function fault(info:Object):void
		{
			//Test the drill down
			///////////////////////////////////////	
/* 			var kme : KalturaBaseEntry = new KalturaMediaEntry();
			kme.id = "00_e6cf46wd"; //TESTING!!!!!!
			_model.reportDataMap[_model.currentScreenState].seletedMediaEntry = kme; */
			///////////////////////////////////////	
			_model.loadingEntryFlag = false;
			_model.checkLoading();
		}
		
	}
}