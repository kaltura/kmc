package com.kaltura.kmc.modules.content.events {
	import com.adobe.cairngorm.control.CairngormEvent;

	public class WindowEvent extends CairngormEvent {
		public static const CLOSE:String = "content_close";
		public static const OPEN:String = "content_open";

		private var _windowState:String = null;


		public function WindowEvent(type:String, windowState:String = null, bubbles:Boolean = false,
									cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_windowState = windowState;
		}


		public function get windowState():String {
			return _windowState;
		}

	}
}