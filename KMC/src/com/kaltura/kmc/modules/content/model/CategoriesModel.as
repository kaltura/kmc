package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CategoriesModel {
		
		/**
		 * categories selected in the table 
		 */		
		public var selectedCategories:Array;
		
		/**
		 * categories returned from latest list action 
		 */		
		public var categoriesList:ArrayCollection;
		
		/**
		 * the totalCount of the latest list action 
		 */		
		public var totalCategories:int;
		
		/**
		 * the filter used for the latest list action 
		 */		
		public var filter:KalturaCategoryFilter;
		
		/**
		 * the pager used for the latest list action 
		 */
		public var pager:KalturaFilterPager;
		

		
	}
}