package com.kaltura.edw.events
{
	import flash.events.Event;
	
	public class KedErrorEvent extends Event {
		
		public static const ERROR:String = "kedError";
		
		
		private var _error:String;
		
		public function KedErrorEvent(type:String, text:String, bubbles:Boolean = true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_error = text;
		}
		
		
		/**
		 * description of the error associated with this event 
		 */		
		public function get error():String {
			return _error;
		}
	}
}