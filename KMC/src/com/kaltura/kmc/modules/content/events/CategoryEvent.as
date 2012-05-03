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
		 * List the metadata data/ info of the selected category.
		 */
		public static const LIST_METADATA_INFO : String = "content_listCategoryMetadataInfo";
		
		/**
		 * delete a category
		 * event.data is an array of category ids 
		 */
		public static const DELETE_CATEGORIES : String = "content_deleteCategories";
		
		/**
		 * Update the selected category with new set values.
		 */
		public static const UPDATE_CATEGORY : String = "content_updateCategory";
		
		/**
		 * Add a new category with new set values.
		 */
		public static const ADD_CATEGORY    : String = "content_addCategory";
		
		/**
		 * Update the metadata data of the selected category.
		 */
		public static const UPDATE_CATEGORY_METADATA_DATA : String = "content_updateCategoryMetadataData";
		
		/**
		 * Retrieve the parent kaltura category object of the selected category.
		 */
		public static const GET_PARENT_CATEGORY : String = "content_getParentCategory";

		/**
		 * Retrieve the inherited parent category of the selected category.
		 */
		public static const GET_INHERITED_PARENT_CATEGORY : String = "content_getInheritedParentCategory";
		
		/**
		 * Clear parent + inherited parent category from the model.
		 */
		public static const CLEAR_PARENT_CATEGORY : String = "content_clearParentCategory";
		
		/**
		 * Set the selected category in the category drilldown.
		 */
		public static const SET_SELECTED_CATEGORY : String = "content_setSelectedCategory";
		
		/**
		 * list category users
		 * event.data is [filter, pager]
		 */
		public static const LIST_CATEGORY_USERS : String = "content_listCategoryUsers";
		
		/**
		 * add the users associated with parent category to the current selected category
		 * event.data is current category
		 */
		public static const INHERIT_USERS_FROM_PARENT : String = "content_inheritUsersFromParent";
		
		/**
		 * add users to the current selected category
		 * event.data is [categoryid, permission level, update method, ([KalturaUsers])]
		 */
		public static const ADD_CATEGORY_USERS : String = "content_addCategoryUsers";
		
		
		
		
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}