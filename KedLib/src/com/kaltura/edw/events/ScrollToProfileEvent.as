package com.kaltura.edw.events
{
	import flash.events.Event;

	/**
	 * This event will be used for scrolling to a selected child 
	 * @author Michal
	 * 
	 */	
	public class ScrollToProfileEvent extends Event
	{
		public static const SCROLL_TO_SELECTED_CHILD:String = "scrollToSelectedChild";
		public var selectedIndexToScroll:int;
		
		public function ScrollToProfileEvent(type:String, selectedIndexToScroll:int, bubbles:Boolean = true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.selectedIndexToScroll = selectedIndexToScroll;
		}
	
	}
}