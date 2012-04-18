package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CategoryEvent extends CairngormEvent
	{
		
		
		/**
		 * clear the list of subcategories of the current selected category (category drilldown) 
		 */
		public static const RESET_SUB_CATEGORIES : String = "content_resetSubCategories";
		
		/**
		 * get a list of subcategories of the current selected category (category drilldown) 
		 */
		public static const GET_SUB_CATEGORIES : String = "content_getSubCategories";
		
		
		/**
		 * update subcategories order for the current selected category (category drilldown)
		 * event.data is array of KalturaCategories to update 
		 */
		public static const UPDATE_SUB_CATEGORIES : String = "content_updateSubCategories";
		
		
		/**
		 * list categories to show in categories screen 
		 * event.data is [filter, pager]
		 */
		public static const LIST_CATEGORIES : String = "content_listCategories";
		
		
		/**
		 * reparent categories
		 * event.data is [categories to move, new parent] 
		 */
		public static const MOVE_CATEGORIES : String = "content_moveCategories";
		
		
		/**
		 * list categories metadata profiles
		 */
		public static const LIST_METADATA_PROFILES : String = "content_listCategoryMetadataProfiles";
		
		/**
		 * delete a category
		 * event.data is an array of category ids 
		 */
		public static const DELETE_CATEGORIES : String = "content_deleteCategories";
		
		public static const UPDATE_CATEGORY : String = "content_updateCategory";
		
		public static const ADD_CATEGORY    : String = "content_addCategory";
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}