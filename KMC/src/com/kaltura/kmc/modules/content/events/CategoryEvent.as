package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CategoryEvent extends CairngormEvent
	{
		public static const LIST_CATEGORIES : String = "content_listCategories";
		public static const UPDATE_CATEGORY : String = "content_updateCategory";
		public static const DELETE_CATEGORY : String = "content_deleteCategory";
		public static const ADD_CATEGORY    : String = "content_addCategory";
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}