package com.kaltura.kmc.modules.content.events
{
	import flash.events.Event;

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