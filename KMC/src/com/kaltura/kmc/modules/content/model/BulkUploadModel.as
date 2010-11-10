package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.kmc.modules.content.model.search.SearchData;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data used by bulk upload 
	 */
	public class BulkUploadModel {
		
		/**
		 * used to get a pager for Content.contentView.bulkListPager
		 * */
		public var bulkSearchData:SearchData = null;
		
		/**
		 * list of <code>KalturaBulkUpload</code>
		 * used as dataprovider somewhere in <code>BulkUpload</code>
		 * */
		public var ps3BulkUploadData:ArrayCollection = null;
		
		/**
		 * total count for pager somewhere in <code>BulkUpload</code>
		 * */
		public var bulkUploadTotalCount:int = 0;
		
		public var conversionData:ArrayCollection;
		
		public var defaultConversionProfileId:int;
		
		public var bulkUploadFilterPager:KalturaFilterPager;
		
		/**
		 * path to the bulkupload sample file 
		 */		
		public var sampleFileUrl:String;
		
		/**
		 * call this JS function to open CW
		 */
		public var openCw:String = "openCw";
	}
}