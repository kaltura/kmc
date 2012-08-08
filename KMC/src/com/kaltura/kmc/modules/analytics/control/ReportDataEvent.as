package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ReportDataEvent extends CairngormEvent
	{
		static public const SET_REPORT_DATA:String = "analytics_setreportdata";
		
		public var reportType:int;
		public var label:String;
		public var totalHeaders:Array;
		public var tableHeaders:Array;
		public var screenType:int;
		public var pageSize:int;
		
		public function ReportDataEvent(type:String, reportType:int, screenType:int, label:String, totalHeaders:Array, tableHeaders:Array, pageSize:int = 25)
		{
			super(type);
			this.reportType = reportType;
			this.label = label;
			this.totalHeaders = totalHeaders;
			this.tableHeaders = tableHeaders;
			this.screenType = screenType;
			this.pageSize = pageSize;
		}
	}
}