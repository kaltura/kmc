package com.kaltura.kmc.events {
	import flash.events.Event;

	/**
	 * The NavigationEvent class represents an event that modules
	 * dispatch in order to navigate to a new module / sub-module.
	 * This class also lists the names (ids) of the different modules.
	 * @author Atar
	 */
	public class NavigationEvent extends Event {

		/**
		 * The NavigationEvent.NAVIGATE constant defines the value of the 
		 * <code>type</code> property of the event object 
		 * for a <code>navigate</code> event.
		 *
		 * @eventType navigate
		 */
		public static const NAVIGATE:String = "navigate";

		private var _module:String;

		private var _subtab:String;


		public function NavigationEvent(type:String, module:String, subtab:String = "",
										bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_module = module;
			_subtab = subtab;
		}


		/**
		 * name of module to show
		 */
		public function get module():String {
			return _module;
		}


		/**
		 * (Optional) name of subtab to show on the module.
		 */
		public function get subtab():String {
			return _subtab;
		}


	}
}