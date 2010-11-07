package com.kaltura.kmc.modules.analytics.vo
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class FilterVo
	{
		public static const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
		
		public var selectedDate : String = ResourceManager.getInstance().getString('analytics', 'last30Days');
		public var fromDate : Date;
		public var toDate : Date;
		public var categories : String;
		public var keywords : String;
		public var searchInAdminTags : Boolean = false;
		public var searchInTags : Boolean = true;
		
		public function FilterVo()
		{
			var today : Date = new Date();
			var todaysHourInMiliSeconds : Number = (((today.hours)*60 + today.minutes)*60 + today.seconds)*1000 + today.milliseconds;
			fromDate= new Date( Number(today.time - todaysHourInMiliSeconds) - millisecondsPerDay*31);
			toDate = new Date( Number(today.time - todaysHourInMiliSeconds) - millisecondsPerDay );
		}
	}
}