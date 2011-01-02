package com.kaltura.kmc.modules.admin.control.events
{
	import flash.events.Event;
	
	public class GeneralEvent extends Event {
		
		protected var _data:Object;
		
		public function GeneralEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}