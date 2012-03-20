package com.kaltura.edw.components.fltr.cat.events
{
	import flash.events.Event;
	
	public class CatTreePrefsEvent extends Event {
		
		
		/**
		 * value for "type" property of preferenced changed event 
		 */		
		public static const PREFS_CHANGED:String = "prefsChanged"
		
		private var _newValue:int;

		
		/**
		 * new value required for tree mode 
		 */
		public function get newValue():int
		{
			return _newValue;
		}

		
		public function CatTreePrefsEvent(type:String, value:int, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_newValue = value;
		}
	}
}