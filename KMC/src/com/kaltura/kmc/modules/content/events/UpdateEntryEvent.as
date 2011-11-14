package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class UpdateEntryEvent extends CairngormEvent {
		
		/**
		 * update the given entry in the entries list
		 * "data" attribute holds the new entry 
		 * */
		public static const UPDATE_ENTRY_IN_LIST:String = "updateEntryInList";
		
		
		
		public function UpdateEntryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}