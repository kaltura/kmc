package com.kaltura.kmc.modules.analytics.model.reportdata {
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFilterPager;

	import mx.collections.ArrayCollection;

	[Bindable]
	public class ReportData {
		static public const DEF_PAGER_SIZE:uint = 25;

		/**
		 * report type
		 * @see com.kaltura.types.KalturaReportType
		 * */
		public var type:int;


		/**
		 * report friendly name
		 */
		public var title:String;


		/**
		 * report general message,
		 * i.e. "X media entries were played Y times"
		 * @private
		 * set in KalturaReportView's holders selectedReportChange() methods
		 */
		public var message:String;


		/**
		 * a message to show in case keywords are filtered
		 */
		public var filterMessage:String;

		/**
		 * in drilldown reports, report subject.
		 */
		public var objectIds:String;
		
		/**
		 * name of drilldown subject
		 */
		public var objectName:String;

		/**
		 * headers for aggregated data
		 */
		public var totalHeaders:Array;

		/**
		 * data for "totals" line
		 */
		public var aggregatedData:ArrayCollection;

		/**
		 * headers for table
		 */
		public var tableHeaders:Array;

		/**
		 * table order
		 */
		public var orderBy:String;

		/**
		 * optional graph dimensions 
		 */
		public var dimArrColl:ArrayCollection = new ArrayCollection();
		
		/**
		 * graph data by report dimension id 
		 */
		public var dimToChartDpMap:Object = new Object();
		
		/**
		 * data provider for the chart, 
		 * one of the arrays listed in <code>dimToChartDpMap</code>  
		 */		
		public var chartDp:ArrayCollection;
		
		/**
		 * id of currently selected graph dimension
		 */
		public var selectedDim:String;
		
		/**
		 * in entry reports, the selected entry 
		 */		
		public var selectedMediaEntry:KalturaBaseEntry;

		/**
		 * the data field for each table column 
		 */
		public var dataFieldDp:Array;
		
		/**
		 * original table headers, 
		 * used when exporting to csv 
		 */
		public var originalTableHeaders:Array;
		
		/**
		 * original totals (aggregates) headers, 
		 * used when exporting to csv 
		 */
		public var originalTotalHeaders:Array;
		
		public var wasObjectIdDropped:Boolean = false;
		public var tableDp:ArrayCollection;
		public var pager:KalturaFilterPager;
		public var totalCount:int = 0;

		public var mapDp:ArrayCollection;

		public var baseTotals:Array;
	}
}
