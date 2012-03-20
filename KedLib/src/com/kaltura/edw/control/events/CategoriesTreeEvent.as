package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;

	public class CategoriesTreeEvent extends KMvCEvent {
		
		
		/**
		 * list all categories in the tree ("old" behaviour) 
		 */
		public static const LIST_ALL_CATEGORIES:String = "list_all_categories"; 

		/**
		 * list categories one level under a given branch.
		 * event.data is the "branch" categoryVO or null for root
		 */
		public static const LIST_CATEGORIES_UNDER:String = "list_categories_under"; 

		/**
		 * flush all categories data 
		 */
		public static const FLUSH_CATEGORIES:String = "flush_categories"; 

		/**
		 * flush all categories data 
		 */
		public static const CREATE_ROOT_CATEGORY:String = "create_root_category"; 
		
		public function CategoriesTreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}