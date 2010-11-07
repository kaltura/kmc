package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PageEvent extends CairngormEvent
	{
		public static const PAGE_CHANGE : String = "analytics_pageChange";
		
		public var currentPage : int = 1;
		public var currentSize : int = 10;
		public var reportType : int;
		public function PageEvent(type:String , currentPage : int , currentSize : int , reportType : int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.currentPage = currentPage;
			this.currentSize = currentSize;
			this.reportType = reportType;
		}	
	}
}