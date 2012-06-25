package com.kaltura.controls.pagingClasses
{
	import flash.events.Event;
	
	public class PagingBehaviorEvent extends Event
	{
		static public const SELECTED_PAGE_CHANGED:String = "behaviorSelectedPageChanged";
		public function PagingBehaviorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}