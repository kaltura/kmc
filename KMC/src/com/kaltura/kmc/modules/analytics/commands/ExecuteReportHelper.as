package com.kaltura.kmc.modules.analytics.commands
{
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	public class ExecuteReportHelper
	{
		private var _model : AnalyticsModelLocator = AnalyticsModelLocator.getInstance();
		
		public function ExecuteReportHelper(){}

		public function reportSetupBeforeExecution() : void
		{
			DrillDownLinkButton.showRefererIcon = false;
			if(_model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN)
				DrillDownLinkButton.showRefererIcon = true;
		}
		
		/**
		 * creates a new KalturaReportInputFilter from the current filter in the KMCModelLocator instance 
		 * @return krif the new KalturaReportInputFilter
		 * 
		 */		
		public function createFilterFromCurrentReport() : KalturaReportInputFilter
		{
			var krif : KalturaReportInputFilter = new KalturaReportInputFilter();
			var today : Date = new Date();
			if( _model.filter )
			{
				krif.fromDate = Math.ceil(_model.filter.fromDate.time/1000);
				krif.toDate = Math.ceil(_model.filter.toDate.time/1000);
				krif.keywords = _model.filter.keywords;
				krif.categories = _model.filter.categories;
				krif.searchInTags =  _model.filter.searchInTags;
				krif.searchInAdminTags = _model.filter.searchInAdminTags;
				// add time offset in minutes.
				krif.timeZoneOffset = new Date().timezoneOffset;
			}
			
			return krif;
		}
	}
}