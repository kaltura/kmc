package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CategoryEvent extends CairngormEvent
	{
		
		
		/**
		 * set the refreshCategoriesRequired flag
		 * event.data is new value 
		 */
		public static const SET_REFRESH_REQUIRED : String = "content_setRefreshCatsRequired";
		
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
		 * set the listing of the currently selected categories
		 * event.data is new listing value (KalturaAppearInListType)
		 */
		public static const SET_CATEGORIES_LISTING : String = "content_setCategoriesListing";
		
		/**
		 * set the contribution policy of the currently selected categories
		 * event.data is new contributnio policy value (KalturaContributionPolicyType)
		 */
		public static const SET_CATEGORIES_CONTRIBUTION : String = "content_setCategoriesContribution";
		
		/**
		 * set the access of the currently selected categories
		 * event.data is new access value (KalturaPrivacyType)
		 */
		public static const SET_CATEGORIES_ACCESS : String = "content_setCategoriesAccess";
		
		
		/**
		 * set the owner of the currently selected categories
		 * event.data is new owner (user id)
		 */
		public static const SET_CATEGORIES_OWNER : String = "content_setCategoriesOwner";
		
		/**
		 * delete a category
		 * event.data is: [[categoryIds], hasSub] (second parameter only relevant if categoryIds.length == 1) 
		 * if event has no data, selectedCategories on the model are used
		 */
		public static const DELETE_CATEGORIES : String = "content_deleteCategories";
		
		/**
		 * save the given categories to the server
		 * event.data is [KalturaCategories]
		 */
		public static const UPDATE_CATEGORIES : String = "content_updateCategories";
		
		/**
		 * Update the selected category with new set values.
		 * event.data is [CategoryVO]
		 */
		public static const UPDATE_CATEGORY : String = "content_updateCategory";
		
		/**
		 * Add a new category with new set values.
		 * event.data is [CategoryVO, saveMetadataFlag]
		 */
		public static const ADD_CATEGORY    : String = "content_addCategory";
		
		/**
		 * Update the metadata data of the selected category.
		 * event.data is category id
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
		 * clear list of category users on model.
		 */
		public static const RESET_CATEGORY_USER_LIST:String = 'content_resetCategoryUserList';
		
		
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}