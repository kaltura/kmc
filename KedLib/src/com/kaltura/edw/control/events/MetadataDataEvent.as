package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;
	
	/**
	 * This class represents event related to metadata
	 * @author Michal
	 * 
	 */
	public class MetadataDataEvent extends KMvCEvent
	{
		public static const ADD : String = "content_add";
		public static const LIST : String = "content_list";
		public static const UPDATE : String = "content_update";

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