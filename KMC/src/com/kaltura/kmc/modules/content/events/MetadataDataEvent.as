package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * This class represents event related to metadata
	 * @author Michal
	 * 
	 */
	public class MetadataDataEvent extends CairngormEvent
	{
		public static const ADD : String = "add";
		public static const LIST : String = "list";
		public static const UPDATE : String = "update";

		/**
		 * Constructs a new MetadataDataEvent 
		 * @param type the type of the event: add / list / update
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function MetadataDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}