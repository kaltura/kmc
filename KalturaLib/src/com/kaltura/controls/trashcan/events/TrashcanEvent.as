package com.kaltura.controls.trashcan.events
{
	import flash.events.Event;

	public class TrashcanEvent extends Event
	{
		static public var REMOVE_ALL:String = "removeAll";
		static public var REMOVE_ITEM:String = "removeItem";
		public var droppedData:Object;

		public function TrashcanEvent (type:String, dropped_data:Object):void
		{
			super (type, true, false);
			droppedData = dropped_data;
		}

		override public function clone():Event
		{
			return new TrashcanEvent (type, droppedData);
		}
	}
}