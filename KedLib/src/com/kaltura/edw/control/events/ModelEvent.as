package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class ModelEvent extends KMvCEvent {
		
		/**
		 * create a new entryDetailsModel, copy general attributes
		 * and push it to the entryDetailsModels array 
		 */
		public static const DUPLICATE_ENTRY_DETAILS_MODEL:String = "duplicate_entry_details_model"; 
		
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}