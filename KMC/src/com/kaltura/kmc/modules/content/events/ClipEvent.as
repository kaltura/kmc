package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ClipEvent extends CairngormEvent {
		
		/**
		 * get a list of clips derived from the given entry.
		 * event.data should be {id:id of the root entry, pager:kalturaPager}
		 */		
		public static const GET_ENTRY_CLIPS:String = "GET_ENTRY_CLIPS";
		
		/**
		 * reset the list on the model of entry clips
		 * */
		public static const RESET_MODEL_ENTRY_CLIPS:String = "RESET_MODEL_ENTRY_CLIPS";
		
		
		public function ClipEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}