package com.kaltura.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * this class represents events related to metadataProfile
	 * @author Michal
	 * 
	 */
	public class MetadataProfileEvent extends CairngormEvent
	{
		public static const LIST : String = "listMetadataProfile";
		public static const ADD : String = "addMetadataProfile";
		public static const UPDATE : String = "updateMetadataProfile";
		
		public function MetadataProfileEvent( type:String,
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}