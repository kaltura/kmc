package com.kaltura.utils.pager
{
	import flash.events.Event;

	public class PagerEvent extends Event
	{
		public static const LOCAL_PAGE_NUM_CHANGED:String		= "localPageNumChanged";
		public static const REMOTE_PAGE_NUM_CHANGED:String		= "remotePageNumChanged";
		public static const TOTAL_PAGES_CHANGED:String 			= "totalPagesChanged";
		public static const FIRST_PAGE:String 					= "firstPage";
		public static const LAST_PAGE:String 					= "lastPage";

		public var localPageNum:int;
		public var remotePageNum:int;
		public var totalPages:int;

		public function PagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, localPageNum:int = -1, remotePageNum:int = -1, totalPages:int = -1)
		{
			super(type, bubbles, cancelable);

			this.localPageNum 	= localPageNum;
			this.remotePageNum 	= remotePageNum;
			this.totalPages 	= totalPages;
		}

	}
}