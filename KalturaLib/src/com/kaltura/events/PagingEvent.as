package com.kaltura.events
{
	import flash.events.Event;

	public class PagingEvent extends Event
	{
		public static const FIRST_PAGE : String = "firstPage";
		public static const LAST_PAGE : String = "lastPage";
		public static const PRV_PAGE : String = "prvPage";
		public static const NEXT_PAGE : String = "nextPage";
		public static const GET_PAGE_NUM : String = "getPageNum";
		public static const ROWS_IN_PAGE_CHANGE : String = "rowsInPageChange";
		
		public function PagingEvent( type:String,
									 oldPageIndex : int = -1,
									 newPageIndex : int = -1,
									 rowsInPage : int = 10, 
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}