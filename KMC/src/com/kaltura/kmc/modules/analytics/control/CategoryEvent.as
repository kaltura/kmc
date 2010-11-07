package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CategoryEvent extends CairngormEvent
	{
		public static const LIST_CATEGORIES : String = "analytics_listCategories";
		public static const UPDATE_CATEGORY : String = "analytics_updateCategory";
		public static const DELETE_CATEGORY : String = "analytics_deleteCategory";
		public static const ADD_CATEGORY    : String = "analytics_addCategory";
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}