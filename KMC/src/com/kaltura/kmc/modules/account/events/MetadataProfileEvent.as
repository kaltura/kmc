package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * this class represents events related to metadataProfile
	 * @author Michal
	 * 
	 */
	public class MetadataProfileEvent extends CairngormEvent {
		
		public static const LIST : String = "account_listMetadataProfile";
		public static const ADD : String = "account_addMetadataProfile";
		public static const UPDATE : String = "account_updateMetadataProfile";
		
		public function MetadataProfileEvent( type:String,
											  bubbles:Boolean=false, 
											  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}