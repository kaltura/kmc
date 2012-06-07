package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ReportEvent extends CairngormEvent
	{
		public static const GET_MULTI_DATA : String = "analytics_getMultiData";
		public static const GET_GRAPH : String = "analytics_getGraph";
		public static const GET_TOTAL : String = "analytics_getTotal";
		public static const GET_TABLE : String = "analytics_getTable";
		public static const GET_ENTRY : String = "analytics_getEntry";
		public static const EXPORT_TO_EXCEL : String = "analytics_exporttoExcel";
		public static const GET_BASE_TOTALS : String = "analytics_getBaseTotals";
		
		public var reportType : int;
		public var orderBy : String;
		public var getTable : Boolean; 
		public var getGraph : Boolean;
		public var getTotal : Boolean; 
		public var getEntry : Boolean;
		public var addTableTotals:Boolean;
		public var addGraphTotals:Boolean;
		
		public function ReportEvent( type:String, 
									 reportType : int , 
									 orderBy : String = '',
									 getTable : Boolean = true, 
									 getGraph : Boolean = true, 
									 getTotal : Boolean = true, 
									 getEntry : Boolean = false,
									 addTableTotals : Boolean = false,
									 addGraphTotals : Boolean = false,
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.reportType = reportType;
			this.orderBy = orderBy;
			this.getTable = getTable;
			this.getGraph = getGraph;
			this.getTotal = getTotal;
			this.getEntry = getEntry;
			this.addTableTotals = addTableTotals;
			this.addGraphTotals = addGraphTotals;
		}
	}
}