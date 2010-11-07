package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.MetadataFieldVO;
	
	/**
	 * This class represents an event indicating some change was done in the metadata fields 
	 * @author Michal
	 * 
	 */	
	public class MetadataFieldEvent extends CairngormEvent
	{	
		public static const DELETE : String = "account_deleteField";
		public static const ADD : String = "account_addField";
		public static const EDIT : String = "account_editField";
		public static const REORDER : String = "account_reorderFields";
		
		public var metadataFields:Array;
		
		/**
		 * Constructs a new MetadataFieldEvent  
		 * @param type the type of the event: deleteField / addField / editField / reorderFields
		 * @param metadataField the field that the change was done on
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function MetadataFieldEvent( type:String, metadataFields:Array = null,
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			this.metadataFields = metadataFields;
			super(type , bubbles, cancelable);
		}	


	}
}