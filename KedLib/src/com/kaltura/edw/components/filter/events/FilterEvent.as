package com.kaltura.edw.components.filter.events
{
	import com.kaltura.edw.events.KedDataEvent;
	
	import flash.events.Event;
	
	public class FilterEvent extends KedDataEvent {
		
		/**
		 * defines the value of the type property of the newSearch event.
		 * */
		public static const NEW_SEARCH:String = 'newSearch';
		
		/**
		 * defines the value of the type property of the addCategory event.
		 * event.data is the category to be added
		 * */
		public static const ADD_CATEGORY:String = 'addCategory';
		
		/**
		 * defines the value of the type property of the deleteCategory event.
		 * event.data is the id of the category to be deleted
		 * */
		public static const DELETE_CATEGORY:String = 'deleteCategory';
		
		/**
		 * defines the value of the type property of the updateCategory event.
		 * event.data is the category to be updated
		 * */
		public static const UPDATE_CATEGORY:String = 'updateCategory';
		
		/**
		 * add entries to category
		 * event.data is ArrayCollection of KalturaBaseEntry objects to be saved 
		 */		
		public static const UPDATE_ENTRIES:String = "updateEntries";
		
		public function FilterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var e:FilterEvent = new FilterEvent(this.type, this.bubbles, this.cancelable);
			e.data = this.data;
			return e;
		}
		
	}
}