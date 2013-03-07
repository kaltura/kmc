package com.kaltura.kmc.modules.analytics.commands {
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.view.renderers.DrillDownLinkButton;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	import com.kaltura.types.KalturaReportInterval;
	import com.kaltura.vo.KalturaEndUserReportInputFilter;
	import com.kaltura.vo.KalturaReportInputFilter;
	
	import mx.resources.ResourceManager;
	import mx.formatters.DateFormatter;

	public class ExecuteReportHelper {
		private static var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();

		private static var dateFormatter:DateFormatter; 
		
		public function ExecuteReportHelper() {
		}


		public static function reportSetupBeforeExecution():void {
			_model.showRefererIcon = false;
			if (_model.currentScreenState == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN)
				_model.showRefererIcon = true;
		}

		
		private static function initDateFormatter():void {
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYYMMDD"; 
		}
		
		
		public static function getObjectIds(screenType:int):String {
			// specific object (drilldown):
			var objectIds:String = '';
			if (_model.selectedEntry && 
				(screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
				|| screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
				|| screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
				|| screenType == ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN 
				|| screenType == ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN 
				|| screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN
				|| screenType == ScreenTypes.PLATFORM_DRILL_DOWN)) {
				objectIds = _model.selectedReportData.objectIds = _model.selectedEntry;
			}
			return objectIds;
		}
		
		
		/**
		 * create the filter for the given report
		 * @param fvo	filter vo from screen
		 * @param screenType	screen type
		 * @return	filter object that should be sent to server 
		 */
		public static function createFilterFromReport(fvo:FilterVo, screenType:int):KalturaReportInputFilter {
			var krif:KalturaReportInputFilter;
			//If we have a user report call we need to have another filter (that support application and users) 
			//when we generate the report get total call
			if (_model.entitlementEnabled && 
				(screenType == ScreenTypes.END_USER_ENGAGEMENT 
					|| screenType == ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN 
					|| screenType == ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT 
					|| screenType == ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF 
					|| screenType == ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS 
					|| screenType == ScreenTypes.END_USER_STORAGE 
					|| screenType == ScreenTypes.END_USER_STORAGE_DRILL_DOWN)) {
				krif = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen(screenType));
			}
			else if (screenType == ScreenTypes.PLATFORM
					|| screenType == ScreenTypes.PLATFORM_DRILL_DOWN
					|| screenType == ScreenTypes.OS
					|| screenType == ScreenTypes.BROWSER) {
				krif = ExecuteReportHelper.createEndUserFilterFromCurrentReport(_model.getFilterForScreen(screenType));
			}
			else {
				krif = ExecuteReportHelper.createFilterFromCurrentReport(_model.getFilterForScreen(screenType));
			}
			return krif;
		}
		
		

		/**
		 * creates a new KalturaReportInputFilter from the current filter in the KMCModelLocator instance
		 * @return krif the new KalturaReportInputFilter
		 *
		 */
		public static function createFilterFromCurrentReport(fvo:FilterVo):KalturaReportInputFilter {
			var krif:KalturaReportInputFilter = new KalturaReportInputFilter();
			var today:Date = new Date();
			if (fvo) {
				// filter dates are in seconds, Date.time is in ms, Date.timezoneOffset is in minutes.
				if (!dateFormatter) initDateFormatter();
				// use new filters (YYYYMMDD). send local date.
				krif.fromDay = dateFormatter.format(fvo.fromDate);
				krif.toDay = dateFormatter.format(fvo.toDate);
				krif.keywords = fvo.keywords;
				krif.categories = fvo.categories;
				krif.searchInTags = true;
				krif.searchInAdminTags = false;
				
				if (fvo.interval != null){
					krif.interval = fvo.interval;
				}
				// add time offset in minutes.
				krif.timeZoneOffset = today.timezoneOffset;
			}

			return krif;
		}
		
		public static function createEndUserFilterFromCurrentReport(fvo:FilterVo):KalturaEndUserReportInputFilter{
			var keurif:KalturaEndUserReportInputFilter = new KalturaEndUserReportInputFilter();
			var today:Date = new Date();
			if (fvo) {
				// filter dates are in seconds, Date.time is in ms, Date.timezoneOffset is in minutes.
				if (!dateFormatter) initDateFormatter();
				// use new filters (YYYYMMDD). send local date.
				keurif.fromDay = dateFormatter.format(fvo.fromDate);
				keurif.toDay = dateFormatter.format(fvo.toDate);
				
				keurif.keywords = fvo.keywords;
				
				//if we selected specific application
				if(fvo.application != ResourceManager.getInstance().getString('analytics', 'all'))
					keurif.application = fvo.application;
				
				if (fvo.interval != null){
					keurif.interval = fvo.interval;
				}
				
				keurif.userIds = fvo.userIds;
				keurif.playbackContext = fvo.playbackContext;
				keurif.categories = fvo.categories;
				keurif.searchInTags = true;
				keurif.searchInAdminTags = false;
				// add time offset in minutes.
				keurif.timeZoneOffset = today.timezoneOffset;
			}
			
			return keurif; 
		}
	}
}