package com.kaltura.kmc.modules.analytics.model.reportdata
{
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ReportData
	{
		public var type : int;
		public var title : String;
		public var message : String;
		public var filterMessage : String;
		public var totalHeaders : Array;
		public var tableHeaders : Array;
		public var objectIds : String;
		public var objectName : String;
		
		//public var filter :FilterVo;
		public var orderBy : String;
		public var aggregatedDataArrCol : ArrayCollection; 
		
		public var dimArrColl : ArrayCollection = new ArrayCollection();
		public var dimToChartDpMap : Object = new Object();
		public var chartDp : ArrayCollection;
		public var selectedDim : String;
		public var seletedMediaEntry : KalturaBaseEntry;
		
		public var dataFieldDp : Array;
		public var tableDp: ArrayCollection;
		public var pager : KalturaFilterPager;
		public var totalCount : int;
		
		public var mapDp : ArrayCollection;
		
		public var baseTotals : Array;
	}
}