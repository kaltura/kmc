package com.kaltura.kmc.modules.account.control.events
{
	import com.kaltura.vo.MetadataFieldVO;
	
	import flash.events.Event;
	
	/**
	 * This class represents an event indicating that a metadata field has been added
	 * @author Michal
	 * 
	 */	
	public class AddMetadataFieldEvent extends Event
	{
		public static const ADD:String = "account_addNewField";
		public var metadataField:MetadataFieldVO;
		
		/**
		 * Constructs a new AddMetadataFieldEvent 
		 * @param type the type of the event
		 * @param metadataField the field that was added
		 * @param bubbles 
		 * @param cancelable
		 * 
		 */		
		public function AddMetadataFieldEvent(type:String, metadataField:MetadataFieldVO,
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			this.metadataField = metadataField;
			super(type, bubbles, cancelable);
		}

	}
}