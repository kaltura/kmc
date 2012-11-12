package com.kaltura.kmc.modules.analytics.model.reportdata
{
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ReportData
	{
		static public const DEF_PAGER_SIZE:uint = 25;
		
		public var type : int;
		public var title : String;
		public var message : String;
		public var filterMessage : String;
		public var totalHeaders : Array;
		public var tableHeaders : Array;
		
		/**
		 * in drilldown reports, report subject.
		 */
		public var objectIds : String;
		public var objectName : String;
		
		//public var filter :FilterVo;
		public var orderBy : String;
		public var aggregatedData : ArrayCollection; 
		
		public var dimArrColl : ArrayCollection = new ArrayCollection();
		public var dimToChartDpMap : Object = new Object();
		public var chartDp : ArrayCollection;
		public var selectedDim : String;
		public var selectedMediaEntry : KalturaBaseEntry;
		
		public var dataFieldDp : Array;
		public var originalTableHeaders:Array;
		public var originalTotalHeaders:Array;
		public var wasObjectIdDropped:Boolean = false;
		public var tableDp: ArrayCollection;
		public var pager : KalturaFilterPager;
		public var totalCount : int = 0;
		
		public var mapDp : ArrayCollection;
		
		public var baseTotals : Array;
	}
}