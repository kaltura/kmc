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
		 */
		public var categories:String;
		
		/**
		 * comma-separated list of categories full-names to be used as required playback context.
		 */
		public var playbackContext:String;

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
