package com.kaltura.edw.components.fltr.cat.events
{
	import flash.events.Event;
	
	public class CategoriesDataManagerEvent extends Event {
		
		public static const REOPEN_BRANCH:String = "reopenBranch"; 
		
		private var _data:*;

		public function get data():*
		{
			return _data;
		}

		
		public function CategoriesDataManagerEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		
	}
}