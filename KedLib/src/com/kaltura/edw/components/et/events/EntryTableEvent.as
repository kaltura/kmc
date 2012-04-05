package com.kaltura.edw.components.et.events
{
	import com.kaltura.edw.events.KedDataEvent;

	public class EntryTableEvent extends KedDataEvent {
		
		/**
		 * the selected entry/ies in the entry table had changed
		 * */
		public static const SELECTION_CHANGED:String = "selectionChanged";
		
		/**
		 * show the details of the required entry
		 * "data" attribute holds the required entry
		 * */
		public static const SHOW_DETAILS:String = "showDetails";
		
		/**
		 * open preview window with required entry
		 * "data" attribute holds the required entry
		 */		
		public static const OPEN_PREVIEW:String = "openPreview";

		/**
		 * delete an entry
		 * "data" attribute holds the required entry
		 */		
		public static const DELETE_ENTRY:String = "deleteEntry";
		
		
		
		public function EntryTableEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}