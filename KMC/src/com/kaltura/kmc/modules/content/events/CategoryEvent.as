package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.ListableVo;

	public class CategoryEvent extends CairngormEvent
	{
		public static const LIST_CATEGORIES : String = "listCategories";
		public static const UPDATE_CATEGORY : String = "updateCategory";
		public static const DELETE_CATEGORY : String = "deleteCategory";
		public static const ADD_CATEGORY    : String = "addCategory";
		
		public function CategoryEvent( type:String , 
									   bubbles:Boolean=false,
									   cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}