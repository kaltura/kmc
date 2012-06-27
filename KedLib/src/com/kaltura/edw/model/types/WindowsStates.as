package com.kaltura.edw.model.types
{
	/**
	 * <code>WindowsStates</code> lists all the popup windows types in the application
	 */	
	public class WindowsStates
	{
		public static const NONE : String = "none";
		
		public static const ENTRY_DETAILS_WINDOW_CLOSED_ONE : String = "entryDetailsWindowClosedOne";
		
		/**
		 * newly created media entry (prepare video/audio entry) 
		 */
		public static const ENTRY_DETAILS_WINDOW_NEW_ENTRY : String = "entryDetailsWindowNewEntry";
		
		/**
		 * replacement entry details 
		 */
		public static const REPLACEMENT_ENTRY_DETAILS_WINDOW : String = "replacementEntryDetailsWindow";
		
		/**
		 * normal entry drilldown 
		 */
		public static const ENTRY_DETAILS_WINDOW : String = "entryDetailsWindow";
		
		/**
		 * 
		 */		
		public static const ENTRY_DETAILS_WINDOW_SA : String = "entryDetailsWindowSa";
		
		/**
		 * entry drilldown from playlist window 
		 */
		public static const PLAYLIST_ENTRY_DETAILS_WINDOW : String = "playlistEntryDetailsWindow";
		
		/**
		 * manual playlist details 
		 */
		public static const PLAYLIST_MANUAL_WINDOW: String = "playlistManualWindow";
		
		/**
		 * rulebased playlist details
		 */		
		public static const PLAYLIST_RULE_BASED_WINDOW: String = "playlistRuleBasedWindow";
		
		/**
		 * live stream details 
		 */
		public static const ADD_LIVE_STREAM : String = "addLiveStream";
		
		/**
		 * add tags to media entry 
		 */		
		public static const ADD_ENTRY_TAGS_WINDOW : String = "addEntryTagsWindow";
		
		/**
		 * add tags to category 
		 */
		public static const ADD_CATEGORY_TAGS_WINDOW : String = "addCategoryTagsWindow";
		
		/**
		 * remove tags from media entry 
		 */
		public static const REMOVE_ENTRY_TAGS_WINDOW : String = "removeEntryTagsWindow";
		
		/**
		 * remove tags from category 
		 */		
		public static const REMOVE_CATEGORY_TAGS_WINDOW : String = "removeCategoryTagsWindow";
		
		/**
		 * download media 
		 */
		public static const DOWNLOAD_WINDOW : String = "downloadWindow";
		
		public static const PREVIEW : String = "preview";
		
		public static const CHANGE_ENTRY_OWNER_WINDOW : String = "changeEntryOwnerWindow";
		
		/**
		 * remove categories assignment from entries 
		 */
		public static const REMOVE_CATEGORIES_WINDOW : String = "removeCategoriesWindow";
		
		/**
		 * asign categories to entries 
		 */
		public static const ADD_CATEGORIES_WINDOW : String = "addCategoriesWindow";
		
		/**
		 * move categories (reorder in tree) 
		 */
		public static const MOVE_CATEGORIES_WINDOW : String = "moveCategoriesWindow";
		
		/**
		 * move a single category (reorder in tree) 
		 */
		public static const MOVE_CATEGORY_WINDOW : String = "moveCategoryWindow";
		
		/**
		 * category listing settings 
		 */
		public static const CATEGORIES_LISTING_WINDOW : String = "categoriesListingWindow";
		
		/**
		 * categories acces ssettings 
		 */
		public static const CATEGORIES_ACCESS_WINDOW : String = "categoriesAccessWindow";
		
		/**
		 * categories contribution policy settings 
		 */
		public static const CATEGORIES_CONTRIBUTION_WINDOW : String = "categoriesContributionWindow";
		
		/**
		 * set categories owner
		 */
		public static const CATEGORIES_OWNER_WINDOW : String = "categoriesOwnerWindow";
		
		/**
		 * category drilldown
		 */
		public static const CATEGORY_DETAILS_WINDOW:String = "categoryDetailsWindow";
		
		/**
		 * set access control to multiple media entries 
		 */
		public static const SETTING_ACCESS_CONTROL_PROFILES_WINDOW : String = "settingACPsWindow";

		/**
		 * set scheduling to multiple media entries 
		 */
		public static const SETTING_SCHEDULING_WINDOW : String = "settingSchedulingWindow";
	}
}