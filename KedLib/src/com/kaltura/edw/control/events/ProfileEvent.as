package com.kaltura.edw.control.events
{
	import com.kaltura.kmvc.control.KMvCEvent;

	public class ProfileEvent extends KMvCEvent
	{
		/**
		 * create new conversion profile
		 */
		public static const ADD_CONVERSION_PROFILE : String = "content_addConversionProfile";
		
		/**
		 * list conversion profiles 
		 */
		public static const LIST_CONVERSION_PROFILE : String = "content_listConversionProfile";
		
		/**
		 * list conversion profiles, converionProfileAssetParams and flavor params, 
		 * and grioup them into vos that hold all conversion profile info.
		 */
		public static const LIST_CONVERSION_PROFILES_AND_FLAVOR_PARAMS : String = "content_listConversionProfilesAndFlavorParams";
		
		/**
		 * list live conversion profiles 
		 */
		public static const LIST_LIVE_CONVERSION_PROFILES : String = "content_listLiveConversionProfiles";
		
		
		/**
		 * list partner's storage profiles 
		 */
		public static const LIST_STORAGE_PROFILES : String = "content_listStorageProfiles";
		
		public function ProfileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
	}
}