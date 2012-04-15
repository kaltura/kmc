package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class SelectionEvent extends CairngormEvent
	{
		public static const ENTRIES_SELECTION_CHANGED : String = "content_selectionChanged";
		
		public static const CATEGORIES_SELECTION_CHANGED : String = "content_categoriesSelectionChanged";
		
		private var _items : Array;
		
		public function SelectionEvent(type:String, items : Array , bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_items = items;
		}

		public function get items():Array {
			return _items;
		}

	}
}