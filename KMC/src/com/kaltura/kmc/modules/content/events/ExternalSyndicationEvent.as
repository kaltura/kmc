package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ExternalSyndicationEvent extends CairngormEvent
	{
		public static const LIST_EXTERNAL_SYNDICATIONS : String = "listSyndications";
		public static const UPDATE_EXTERNAL_SYNDICATION_CHANGES : String = "updateSyndicationChanges";
		public static const ADD_NEW_EXTERNAL_SYNDICATION : String = "addNewSyndication";
		public static const DELETE_EXTERNAL_SYNDICATION : String = "deleteCheckedSyndication";
		public static const MARK_EXTERNAL_SYNDICATION : String = "markSyndications";
		public static const SET_SYNDICATION_FEED_FILTER_ORDER : String = "setSyndicationFeedFilterOrder";
		
		private var _selected : Boolean;
		
		public function ExternalSyndicationEvent(type:String, 
										  		 selected:Boolean=false , 
										  		 bubbles:Boolean=false, 
										  		 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_selected = selected;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

	}
}