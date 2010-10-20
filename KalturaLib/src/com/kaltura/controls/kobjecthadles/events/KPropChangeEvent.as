package com.kaltura.controls.kobjecthadles.events
{
	import flash.events.Event;

	public class KPropChangeEvent extends Event
	{
		public static const WIDTH_CHANGED_EVENT : String = "widthChangedEvent";
		public static const HEIGHT_CHANGED_EVENT : String = "heightChangedEvent";

		public var newValue : Number;

		public function KPropChangeEvent( type : String , newValue : Number , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.newValue = newValue;
		}
	}
}