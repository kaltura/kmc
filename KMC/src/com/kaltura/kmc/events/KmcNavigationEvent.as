package com.kaltura.kmc.events {
	import flash.events.Event;

	/**
	 * The NavigationEvent class represents an event that modules
	 * dispatch in order to navigate to a new module / sub-module.
	 * @author Atar
	 */
	public class KmcNavigationEvent extends Event {
		
		
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
		
		private var _data:Object;


		public function KmcNavigationEvent(type:String, module:String, subtab:String = "", data:Object = null,
										bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_module = module;
			_subtab = subtab;
			_data = data;
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

		/**
		 * (Optional) any extra data required for the event. </br>
		 * i.e. when appstudio needs to navigate to content and pass 
		 * uiconf id use <code>{uiconfId:333414}</code>
		 */		
		public function get data():Object {
			return _data;
		}


	}
}