package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ReportEvent extends CairngormEvent
	{
		public static const GET_MULTI_DATA : String = "getMultiData";
		public static const GET_GRAPH : String = "getGraph";
		public static const GET_TOTAL : String = "getTotal";
		public static const GET_TABLE : String = "getTable";
		public static const GET_ENTRY : String = "getEntry";
		public static const EXPORT_TO_EXCEL : String = "exporttoExcel";
		
		public var reportType : int;
		public var orderBy : String;
		public var getTable : Boolean; 
		public var getGraph : Boolean;
		public var getTotal : Boolean; 
		public var getEntry : Boolean;
		
		public function ReportEvent( type:String, 
									 reportType : int , 
									 orderBy : String = '',
									 getTable : Boolean = true, 
									 getGraph : Boolean = true, 
									 getTotal : Boolean = true, 
									 getEntry : Boolean = false, 
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
		}
	}
}