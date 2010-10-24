package com.kaltura.kmc.events
{
	import flash.events.Event;
	
	/**
	 * The ErrorEvent class represents errors that KMCModules encounter 
	 * and need to inform the main KMC application. 
	 * @author Atar
	 */	
	public class KmcErrorEvent extends Event {
		
		
		public static const ERROR:String = "kmcError";
		
		
		private var _error:String;
		
		
		public function KmcErrorEvent(type:String, text:String, bubbles:Boolean=false, cancelable:Boolean=false) {
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