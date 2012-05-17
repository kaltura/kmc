package com.kaltura.kmc.modules.analytics.commands {
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import mx.resources.ResourceManager;

	public class ExecuteReportHelper {
		private static var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();


		public function ExecuteReportHelper() {
		}


		public static function reportSetupBeforeExecution():void {
			_model.showRefererIcon = false;
			if (_model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN)
				_model.showRefererIcon = true;
		}


		/**
		 * creates a new KalturaReportInputFilter from the current filter in the KMCModelLocator instance
		 * @return krif the new KalturaReportInputFilter
		 *
		 */
		public static function createFilterFromCurrentReport():KalturaReportInputFilter {
			var krif:KalturaReportInputFilter = new KalturaReportInputFilter();
			var today:Date = new Date();
			var fvo:FilterVo = _model.filter;
			if (fvo) {
				// filter dates are in seconds, Date.time is in ms, Date.timezoneOffset is in minutes.
				krif.fromDate = Math.ceil(fvo.fromDate.time / 1000) - today.timezoneOffset * 60;
				krif.toDate = Math.ceil(fvo.toDate.time / 1000) - today.timezoneOffset * 60;
				krif.keywords = fvo.keywords;
				krif.categories = fvo.categories;
				krif.searchInTags = fvo.searchInTags;
				krif.searchInAdminTags = fvo.searchInAdminTags;
				// add time offset in minutes.
				krif.timeZoneOffset = today.timezoneOffset;
			}

			return krif;
		}
		
		public static function createEndUserFilterFromCurrentReport():KalturaEndUserReportInputFilter{
			var keurif:KalturaEndUserReportInputFilter = new KalturaEndUserReportInputFilter();
			var today:Date = new Date();
			var fvo:FilterVo = _model.filter;
			if (fvo) {
				// filter dates are in seconds, Date.time is in ms, Date.timezoneOffset is in minutes.
				keurif.fromDate = Math.ceil(fvo.fromDate.time / 1000) - today.timezoneOffset * 60;
				keurif.toDate = Math.ceil(fvo.toDate.time / 1000) - today.timezoneOffset * 60;
				keurif.keywords = fvo.keywords;
				
				//if we selected spacific application
				if(fvo.application != ResourceManager.getInstance().getString('analytics', 'all'))
					keurif.application = fvo.application;
				
				keurif.userIds = fvo.userIds;
				keurif.categories = fvo.categories;
				keurif.searchInTags = fvo.searchInTags;
				keurif.searchInAdminTags = fvo.searchInAdminTags;
				// add time offset in minutes.
				keurif.timeZoneOffset = today.timezoneOffset;
			}
			
			return keurif; 
		}
	}
}