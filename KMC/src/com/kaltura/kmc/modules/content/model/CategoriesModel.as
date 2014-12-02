package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.KalturaClient;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUser;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CategoriesModel {
		
		
		/**
		 * if KalturaCategory.tags include this value, 
		 * kmc should show warning when editing it. 
		 * */
		public static const EDIT_WARN_TAG:String = "__EditWarning";
		
		/**
		 * numbers of subcategories that may be reordered 
		 */
		public static const SUB_CATEGORIES_LIMIT:int = 50;
		
		/**
		 * when data is being loaded, value is true.
		 * bound to the general model's loadingFlag and is  
		 * not meant to be changed manually (by convention). 
		 */		
		public var loadingFlag:Boolean;
		
		
		/**
		 * reference to the API client 
		 */
		public var client:KalturaClient;
		
		/**
		 * when acting on a single category, the selected category (category table actions)
		 */		
		public var selectedCategory:KalturaCategory;
		
		/**
		 * categories selected in the table (categories screen)
		 */		
		public var selectedCategories:Array;
		
		/**
		 * categories returned from latest list action (for categories screen)
		 */		
		public var categoriesList:ArrayCollection;
		
		/**
		 * the totalCount of the latest list action (categories screen)
		 */		
		public var totalCategories:int;
		
		/**
		 * the filter used for the latest list action (categories screen)
		 */		
		public var filter:KalturaCategoryFilter;
		
		/**
		 * the pager used for the latest list action (categories screen)
		 */
		public var pager:KalturaFilterPager;
		
		
		
		
		/**
		 * indicates the category currently being edited in 
		 * the category drilldown has not been saved yet.
		 */		
		public var processingNewCategory:Boolean = false;
		
		/**
		 * should categories list be reloaded <br/>
		 * used when closing CDW 
		 */		
		public var refreshCategoriesRequired:Boolean = false;
		
		/**
		 * predefined entries to add to newly created category
		 * (from entries screen>bulk actions)
		 */
		public var onTheFlyCategoryEntries:Array;
		
		
		/**
		 * when saving a category we list all categories that have the same 
		 * referenceId as the category being saved. this is the list.
		 */
		public var categoriesWSameRefidAsSelected:Array;
		
		
		// -----------------------------------------
		// cat.drilldown: metadata tab
		// -----------------------------------------
		
		/**
		 * Metadata info array of the selected category (category metadata --> category drilldown)
		 */		
		public var metadataInfo:ArrayCollection;
		
		
		// -----------------------------------------
		// cat.drilldown: sub categories tab
		// -----------------------------------------
		
		/**
		 * sub categories of selected category (category drilldown) 
		 */
		public var subCategories:ArrayCollection;
		
		
		// -----------------------------------------
		// cat.drilldown: entitlements tab
		// -----------------------------------------
		
		/**
		 * The category from which the selected category inherits values, or the parent category if no inheritedParent .
		 */
		public var inheritedParentCategory:KalturaCategory;
		
		/**
		 * the KalturaUser that is set as owner of the parent category of selected category (category drilldown > ent)
		 */
		public var inheritedOwner:KalturaUser;
		
		/**
		 * the KalturaUser that is set as owner of the selected category (category drilldown > ent) 
		 */		
		public var categoryOwner:KalturaUser;
		
		
		// -----------------------------------------
		// category users popup
		// -----------------------------------------
		
		/**
		 * users associated with selected category (KalturaCategoryUser objects, end users popup)
		 */
		public var categoryUsers:ArrayCollection;
		
		/**
		 * the totalCount of the latest users list action (end users popup)
		 */
		public var totalCategoryUsers:int;
		
		/**
		 * selected users in table (KalturaCategoryUser objects, end users popup)
		 */
		public var selectedCategoryUsers:Array;
		
		/**
		 * indicates the first action in the end users permissions popup had occured
		 * (used to show confirmation message) 
		 */		
		public var categoryUserFirstAction:Boolean;
		
		
		
	}
}