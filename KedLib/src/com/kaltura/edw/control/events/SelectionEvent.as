package com.kaltura.edw.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class SelectionEvent extends CairngormEvent
	{
		public static const SELECTION_CHANGED : String = "content_selectionChanged";
		
		private var _entries : Array;
		
		public function SelectionEvent(type:String, entries : Array , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_entries = entries;
		}

		public function get entries():Array
		{
			return _entries;
		}

	}
}