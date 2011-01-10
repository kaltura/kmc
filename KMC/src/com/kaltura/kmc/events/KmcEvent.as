package com.kaltura.kmc.events
{
	import flash.events.Event;
	
	public class KmcEvent extends Event {
		
		private var _data:Object;
		
		public function KmcEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		public function get data():Object
		{
			return _data;
		}

	}
}