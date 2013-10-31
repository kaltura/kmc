package com.kaltura.kmc.modules.account.events
{
	import flash.events.Event;
	
	public class TranscodingEvent extends Event
	{
		
		/**
		 * defines the "type" property for the changeState event.
		 * event.data is required screen state.  
		 */
		public static const CHANGE_STATE:String = "changeState";
		
		
		private var _data:*;
		
		
		
		public function TranscodingEvent(type:String, data:*, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_data = data;
		}

		
		public function get data():* {
			return _data;
		}

	}
}