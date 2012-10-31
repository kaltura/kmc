package com.kaltura.kmc.modules.analytics.vo {
	import com.kaltura.kmc.modules.analytics.utils.TimeConsts;
	
	import flash.events.EventDispatcher;
	
	import mx.resources.ResourceManager;

	[Bindable]
	public class FilterVo extends EventDispatcher{
		

		public var selectedDate:String;
		public var fromDate:Date;
		public var toDate:Date;

		/**
		 * comma-separated list of categories full-names.
		 * 
		 * @internal
		 * when getting report, the command switches between categories and playbackContext according to required report
		 */
		public var categories:String;

		public var keywords:String;
		
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
		}
	}
}
