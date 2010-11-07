package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ExternalSyndicationEvent extends CairngormEvent
	{
		public static const GET_ALL_EXTERNAL_SYNDICATIONS : String = "account_getAllSyndications";
		public static const SAVE_EXTERNAL_SYNDICATION_CHANGES : String = "account_saveSyndicationChanges";
		public static const ADD_NEW_EXTERNAL_SYNDICATION : String = "account_addNewSyndication";
		public static const DELETE_EXTERNAL_SYNDICATION : String = "account_deleteCheckedSyndication";
		public static const MARK_EXTERNAL_SYNDICATION : String = "account_markSyndications";
		
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