package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * this class represents events related to metadataProfile
	 * @author Michal
	 * 
	 */
	public class MetadataProfileEvent extends CairngormEvent
	{
		public static const LIST : String = "content_listMetadataProfile";
		public static const ADD : String = "content_addMetadataProfile";
		public static const UPDATE : String = "content_updateMetadataProfile";
		
		public function MetadataProfileEvent( type:String,
									 bubbles:Boolean=false, 
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}