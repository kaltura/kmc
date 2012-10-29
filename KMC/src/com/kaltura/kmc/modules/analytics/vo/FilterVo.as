package com.kaltura.kmc.modules.analytics.vo {
	import com.kaltura.kmc.modules.analytics.utils.TimeConsts;

	import mx.resources.ResourceManager;

	[Bindable]
	public class FilterVo {
		

		public var selectedDate:String;
		public var fromDate:Date;
		public var toDate:Date;

		/**
		 * comma-separated list of categories full-names
		 */
		public var categories:String;

		public var keywords:String;
		public var searchInAdminTags:Boolean = false;
		public var searchInTags:Boolean = true;
		public var application:String;
		
		/**
		 * comma-seperated string of user ids 
		 */
		public var userIds:String;
		
		/**
		 * days / months
		 * @see com.kaltura.types.KalturaReportInterval 
		 */
		public var interval:String;


		public function FilterVo() {
//			var today:Date = new Date();
//			var todaysHourInMiliSeconds:Number = (((today.hoursUTC) * 60 + today.minutesUTC) * 60 + today.secondsUTC) * 1000 + today.millisecondsUTC;
//			var todayStart:Number = today.time - todaysHourInMiliSeconds;
//			fromDate = new Date((todayStart - 31 * TimeConsts.DAY + today.timezoneOffset * 60000) + TimeConsts.DAY);
//			toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - 1000) + TimeConsts.DAY);
		}
	}
}
