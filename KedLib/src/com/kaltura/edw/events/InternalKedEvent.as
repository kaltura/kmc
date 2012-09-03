package com.kaltura.edw.events
{
	/**
	 * events for internal KED communication, 
	 * between the different panels and the main app etc. 
	 */
	public class InternalKedEvent extends KedDataEvent {
		
		/**
		 * dispatched when a panel had finished saving its data.
		 * panels which only handle data on the selectedEntry object shouldn't save
		 * their own data, instead they should just dispatch the "saved" event. 
		 */		
		public static const PANEL_DATA_SAVED:String = "panelDataSaved";
		
		
		
		public function InternalKedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}