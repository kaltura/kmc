package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CategoryEvent extends CairngormEvent
	{
		
		
		/**
		 * list categories to show in categories screen 
		 * event.data is [filter, pager]
		 */
		public static const LIST_CATEGORIES : String = "content_listCategories";
		
		
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