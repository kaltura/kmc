package com.kaltura.kmc.modules.content.events
{
	import flash.events.Event;
	
	public class GeneralNonCairngormEvent extends Event {
		
		public var data:*;
		
		public function GeneralNonCairngormEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}