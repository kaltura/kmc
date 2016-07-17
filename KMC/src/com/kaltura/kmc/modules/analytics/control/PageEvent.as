package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;

	public class PageEvent extends CairngormEvent
	{
		public static const PAGE_CHANGE : String = "analytics_pageChange";
		
		public var currentPage : int = 1;
		public var currentSize : int = ReportData.DEF_PAGER_SIZE;
		public var reportType : String;
		public function PageEvent(type:String , currentPage : int , currentSize : int , reportType : String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.currentPage = currentPage;
			this.currentSize = currentSize;
			this.reportType = reportType;
		}	
	}
}