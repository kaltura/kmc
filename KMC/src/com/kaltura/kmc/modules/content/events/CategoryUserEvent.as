package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaCategoryUser;

	public class CategoryUserEvent extends CairngormEvent {
		
		
		/**
		 * save selected category users on model
		 * event.data is ([KalturaCategoryUser])
		 */
		public static const SET_SELECTED_CATEGORY_USERS:String = 'cnt_setSelectedCategoryUsers';
		
		/**
		 * event.data is [desired perm lvl, [KalturaCategoryUser]]
		 */
		public static const SET_CATEGORY_USERS_PERMISSION_LEVEL:String = 'cnt_editCategoryUsersPermissionLevel';
		
		/**
		 * event.data is [KalturaCategoryUser] 
		 */
		public static const SET_CATEGORY_USERS_MANUAL_UPDATE:String = 'cnt_setCategoryUsersManualUpdate';
		
		/**
		 * event.data is [KalturaCategoryUser] 
		 */
		public static const SET_CATEGORY_USERS_AUTO_UPDATE:String = 'cnt_setCategoryUsersAutoUpdate';
		
		/**
		 * add users to the current selected category
		 * event.data is [categoryid, permission level, update method, ([KalturaUsers])]
		 */
		public static const ADD_CATEGORY_USERS : String = "content_addCategoryUsers";
		
		/**
		 * delete category users.
		 * event.data is [KalturaCategoryUser] 
		 */
		public static const DELETE_CATEGORY_USERS:String = 'cnt_deleteCategoryUsers';
		
		/**
		 * add the users associated with parent category to the current selected category
		 * event.data is current category
		 */
		public static const INHERIT_USERS_FROM_PARENT : String = "content_inheritUsersFromParent";
		
		/**
		 * deactivate category users.
		 * event.data is [KalturaCategoryUser] 
		 */
		public static const DEACTIVATE_CATEGORY_USER:String = 'cnt_deactivateCategoryUser';
		
		/**
		 * activate category users.
		 * event.data is [KalturaCategoryUser] 
		 */
		public static const ACTIVATE_CATEGORY_USER:String = 'cnt_activateCategoryUser';
		
		
		
		public function CategoryUserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}