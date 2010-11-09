package com.kaltura.kmc.events {
	import flash.events.Event;

	/**
	 * KmcHelpEvent is the event KMC modules use to request
	 * showing help pages.
	 * @author Atar
	 */
	public class KmcHelpEvent extends Event {

		public static const HELP:String = "help";

		private var _anchor:String;


		public function KmcHelpEvent(type:String, anchor:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_anchor = anchor;
		}


		/**
		 * the anchore on the help page to show
		 */
		public function get anchor():String {
			return _anchor;
		}

	}
}