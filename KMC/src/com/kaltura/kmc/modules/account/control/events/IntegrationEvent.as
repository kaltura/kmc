package com.kaltura.kmc.modules.account.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class IntegrationEvent extends CairngormEvent {
		
		/**
		 * list categories by privacy context 
		 */		
		public static const LIST_CATEGORIES_WITH_PRIVACY_CONTEXT:String = "account_list_categories_with_privacy_context";
		
		/**
		 * save the given category
		 * event.data is KalturaCategory to save 
		 */		
		public static const UPDATE_CATEGORY:String = "account_update_category";
		
		public function IntegrationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}