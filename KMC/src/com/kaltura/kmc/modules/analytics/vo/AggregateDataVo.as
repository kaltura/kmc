package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	public class AggregateDataVo implements IValueObject
	{
		/**
		 * data title 
		 */
		public var title : String;
		
		
		/**
		 * formatted value, to show in aggregate bar 
		 */
		public var formattedValue : String;
		
		
		/**
		 * text to show when hovering over "?" in aggregate bar
		 */
		public var helpToolTip : String;
		
		/**
		 * "real" value, as received from server
		 */
		public var value:String;
	}
}