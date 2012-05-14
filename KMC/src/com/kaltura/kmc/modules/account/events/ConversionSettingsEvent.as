package com.kaltura.kmc.modules.account.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ConversionSettingsEvent extends CairngormEvent
	{
		public static const ADD_CONVERSION_PROFILE : String = "account_addConversionProfile";
		
		/**
		 * delete the given conversion profiles
		 * event.data is [ConversionProfileVO]
		 */
		public static const DELETE_CONVERSION_PROFILE : String = "account_deleteConversionProfile";
		
		public static const LIST_CONVERSION_PROFILES : String = "account_listConversionProfiles";
		public static const LIST_FLAVOR_PARAMS : String = "account_listFlavorParams";
		
		/**
		 * event.data (can be) [pageIndex, pageSize] 
		 */
		public static const LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS : String = "account_listConversionProfilesAndFlavorParams";
		
		public static const MARK_FLAVORS : String = "account_markFlavors";
		public static const UPDATE_CONVERSION_PROFILE : String = "account_updateConversionProfile";
		
		/**
		 * set the given profile as partner default 
		 */
		public static const SET_AS_DEFAULT_CONVERSION_PROFILE : String = "account_setAsDefualtConversionProfile";
		
		/**
		 * list current partner's remote storage profiles
		 */
		public static const LIST_STORAGE_PROFILES : String = "account_listStorageProfiles";
		
		public var selected : Boolean;
		
		public function ConversionSettingsEvent(type:String, 
												selected:Boolean=false, 
												data:Object=null,
										  		bubbles:Boolean=false, 
										  		cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.selected = selected;
			this.data = data;
		}
	}
}