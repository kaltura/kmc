package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ExternalSyndicationEvent extends CairngormEvent
	{
		public static const GET_ALL_EXTERNAL_SYNDICATIONS : String = "getAllSyndications";
		public static const SAVE_EXTERNAL_SYNDICATION_CHANGES : String = "saveSyndicationChanges";
		public static const ADD_NEW_EXTERNAL_SYNDICATION : String = "addNewSyndication";
		public static const DELETE_EXTERNAL_SYNDICATION : String = "deleteCheckedSyndication";
		public static const MARK_EXTERNAL_SYNDICATION : String = "markSyndications";
		
		public var selected : Boolean;
		
		public function ExternalSyndicationEvent(type:String, 
										  		 selected:Boolean=false , 
										  		 bubbles:Boolean=false, 
										  		 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.selected = selected;
			this.data = data;
		}
	}
}