package com.kaltura.analytics {

	public class GoogleAnalyticsConsts {
		public static const PAGE_VIEW:String = "Page view/"; // V
		public static const ACTION:String = "Action/";
		/**
		 * on paging 
		 */
		public static const GO_TO_PAGE:String = "Show rows";
		
		/**
		 * paging: request next page 
		 */
		public static const NEXT_PAGE:String = "Next Page"; 
		
		/**
		 * paging: request previous page
		 */
		public static const PREV_PAGE:String = "Previous Page"; 
		
		/**
		 * paging: goto page 
		 */
		public static const GO_TO_PAGE_NUM:String = "Get Page By Number";

		// ============================================================
		// Content
		// ============================================================
		// ==============================
		// page views
		// ==============================
		public static const CONTENT_ENTRIES:String = "Entries";
		public static const CONTENT_MODERATION:String = "Moderation";
		public static const CONTENT_PLAYLISTS:String = "Playlists";
		public static const CONTENT_SYNDICATION:String = "Syndication";
		public static const CONTENT_UPLOADS:String = "Uploads";
		public static const CONTENT_BULK_UPLOADS:String = "Bulk Uploads";
		public static const CONTENT_DROP_FOLDERS:String = "Drop Folders";
		// ==============================
		public static const CONTENT_DRILLDOWN_METADATA:String = "DrillDown/Metadata";
		public static const CONTENT_DRILLDOWN_THUMBNAILS:String = "DrillDown/Thumbnails";
		public static const CONTENT_DRILLDOWN_ACCESS_CONTROL:String = "DrillDown/Access Control";
		public static const CONTENT_DRILLDOWN_SCHEDULING:String = "DrillDown/Scheduling";
		public static const CONTENT_DRILLDOWN_FLAVORS:String = "DrillDown/Flavors";
		public static const CONTENT_DRILLDOWN_CUSTOM_DATA:String = "DrillDown/Custom Data";
		public static const CONTENT_DRILLDOWN_DISTRIBUTION:String = "DrillDown/Distribution";
		public static const CONTENT_DRILLDOWN_CAPTIONS:String = "DrillDown/Captions";
		public static const CONTENT_DRILLDOWN_ADVERTISEMENTS:String = "DrillDown/Advertisements";
		public static const CONTENT_DRILLDOWN_RELATED_FILES:String = "DrillDown/Related Files";
		public static const CONTENT_DRILLDOWN_CLIPS:String = "DrillDown/Clips";
		public static const CONTENT_DRILLDOWN_CONTENT:String = "DrillDown/Content";
		public static const CONTENT_DRILLDOWN_LIVE:String = "DrillDown/Live Streaming";
		
		// ==============================
		// actions
		// ==============================
		/**
		 * add manual playlist
		 */
		public static const CONTENT_ADD_PLAYLIST:String = "Add Manual Playlist";
		
		/**
		 * add rulebased playlist
		 */
		public static const CONTENT_ADD_RULEBASED_PLAYLIST:String = "Add RuleBased Playlist";
		
		/**
		 * edit playlist entry
		 */
		public static const CONTENT_EDIT_PLAYLIST:String = "Edit Playlist";
		
		/**
		 * delete playlist entry
		 */
		public static const CONTENT_DELETE_PLAYLIST:String = "Delete Playlist";
		
		/**
		 * delete regular entry
		 */
		public static const CONTENT_DELETE_ITEM:String = "Delete Entry";
		
		/**
		 * delete mix entry
		 */
		public static const CONTENT_DELETE_MIX:String = "Delete Mix";

		/**
		 * request save on entry drilldown
		 */
		public static const CONTENT_EDIT_ENTRY:String = "Edited DrillDown"; 

		/**
		 * open entry drilldown
		 */
		public static const CONTENT_ENTRY_DRILLDOWN:String = "Entry DrillDown";
		
		/**
		 * set access control for multiple entries 
		 */
		public static const CONTENT_ACCESS_CONTROL:String = "Set Access Control Multiple Entries";
		
		/**
		 * set scheduling multiple entries
		 */
		public static const CONTENT_SET_SCHEDULING:String = "Set Scheduling Multiple Entries";
		
		/**
		 *  
		 */
		public static const CONTENT_CHANGE_THUMBNAIL:String = "Change Thumbnail"; // V
		
		/**
		 * add tags to multiple entries
		 */
		public static const CONTENT_ADD_TAGS:String = "Add tags Multiple Entries"; 
		
		/**
		 * remove tags from Multiple Entries 
		 */
		public static const CONTENT_REMOVE_TAGS:String = "Remove Tags Multiple Entries"; 
		
		/**
		 * create new category 
		 */
		public static const CONTENT_ADD_CATEGORY:String = "Add Category";
		
		/**
		 * delete existing category
		 */
		public static const CONTENT_DELETE_CATEGORY:String = "Delete Category"; 
		
		/**
		 * download of entry
		 */
		public static const CONTENT_DOWNLOAD:String = "Download";
		
		/**
		 * approve entry moderation 
		 */
		public static const CONTENT_APPROVE_MODERATION:String = "Approve Moderation";
		
		/**
		 * reject entry moderation
		 */
		public static const CONTENT_REJECT_MODERATION:String = "Reject Moderation"; 
		
		
		/**
		 * P&E requested 
		 */
		public static const CONTENT_OPEN_PREVIEW_AND_EMBED:String = "Open Preview and Embed"; 

		public static const CONTENT_FIRST_TIME_PLAYLIST_EMBED:String = "content first time playlist embed";
		
		/**
		 * first time P&E was requested
		 */
		public static const CONTENT_FIRST_TIME_PLAYER_EMBED:String = "content first time player embed"; 
		
		public static const CONTENT_FIRST_TIME_PLAYLIST_CREATION:String = "content first time playlist creation";

		// ==================================================================
		// account settings:
		// ==================================================================
		public static const ACCOUNT_CHANGE_PARTNER_INFO:String = "Account Change Partner Info"; // V
		public static const ACCOUNT_CHANGE_LOGIN_INFO:String = "Account Change Login Info"; // V
		public static const ACCOUNT_CONTACT_US_USAGE:String = "Account Contact Us Usage"; // V
		public static const ACCOUNT_UPDATE_SERVER_SETTINGS:String = "Account Update Server Settings"; // V
		public static const ACCOUNT_ACCESS_CONTROL:String = "Access Control"; // V
		public static const ACCOUNT_TRANSCODING_SETTINGS:String = "Transcoding Settings"; // V
		public static const ACCOUNT_ACCOUNT_UPGRADE:String = "Account Upgrade"; // V
		public static const ACCOUNT_SAVE_SEVER_SETTINGS:String = "Save Server Settings"; // V
		public static const ACCOUNT_ACCESS_CONTROL_DELETE:String = "Access Control Delete"; // V
		public static const ACCOUNT_SAVE_TRANSCODING_SETTINGS:String = " Save Transcoding Settings"; // V

		// ==================================================================
		// dashboard:
		// ==================================================================
		public static const DASHBOARD_UPLOAD_CONTENT:String = "Upload Content"; // V
		public static const DASHBOARD_IMPORT_CONTENT:String = "Import Content";
		public static const DASHBOARD_ACCOUNT_CONTACT_US:String = "Account Contact Us";
		public static const DASHBOARD_VIEW_REPORTS:String = "View Reports";
		public static const DASHBOARD_EMBED_PLAYER:String = "Embed player";
		public static const DASHBOARD_EMBED_PLAYLIST:String = "Embed PlayList";
		public static const DASHBOARD_CUSTOMIZE_PLAYERS:String = "Customize Players";

		//
		public static const LOGIN:String = "User Logs In"; // V
		public static const LOGIN_FIRST_TIME:String = "login first time"; // V


		// ==================================================================
		// studio:
		// ==================================================================
		public static const APP_STUDIO_NEW_PLAYER_SINGLE_VIDEO:String = "App Studio New Player Single Video";
		public static const APP_STUDIO_NEW_PLAYER_PLAYLIST:String = "App Studio New Player Playlist";
		public static const APP_STUDIO_FIRST_NEW_PLAYER_PLAYLIST:String = "App Studio first New Player Playlist";
		public static const APP_STUDIO_NEW_PLAYER_MULTI_TAB_PLAYLIST:String = "App Studio New Player Multitab Playlist";
		public static const APP_STUDIO_EDIT_PLAYER_SINGLE_VIDEO:String = "App Studio Edit Player Single Video";
		public static const APP_STUDIO_EDIT_PLAYER_PLAYLIST:String = "App Studio Edit Player Playlist";
		public static const APP_STUDIO_EDIT_PLAYER_MULTI_TAB_PLAYLIST:String = "App Studio Edit Player Multi Tab Playlist";
		public static const APP_STUDIO_DUPLICATE_PLAYER:String = "App Studio Duplicate Player";

		public static const FUTURE_USE_1:String = "Future Use 1";
		public static const FUTURE_USE_2:String = "Future Use 2";
		public static const FUTURE_USE_3:String = "Future Use 3";

		// ==================================================================
		// analytics:
		// ==================================================================
		public static const REPORTS_AND_ANALYTICS_BANDWIDTH_USAGE_TAB:String = "BandWidth Usage Tab";
		public static const REPORTS_AND_ANALYTICS_BANDWIDTH_USAGE_VIEW_MONTHLY:String = "BandWidth Usage view Monthly";
		public static const REPORTS_AND_ANALYTICS_BANDWIDTH_USAGE_VIEW_YEARLY:String = "BandWidth Usage view Yearly";
		public static const REPORTS_AND_ANALYTICS_CONTENT_REPORTS_TAB:String = "Content Reports Tab";
		public static const REPORTS_AND_ANALYTICS_USERS_AND_COMMUNITY_REPORTS_TAB:String = "Users And Community Reports Tab";
		public static const REPORTS_AND_ANALYTICS_TOP_CONTRIBUTORS:String = "Users And Community Reports Tab>Top Contributors";
		public static const REPORTS_AND_ANALYTICS_MAP_OVERLAYS:String = "Users And Community Reports Tab>Map Contributors";
		public static const REPORTS_AND_ANALYTICS_MAP_OVERLAYS_DRILLDOWN:String = "Users And Community Reports Tab>Map Contributors DrillDown";
		public static const REPORTS_AND_ANALYTICS_TOP_SYNDICATIONS:String = "Users And Community Reports Tab>Top Syndications";
		public static const REPORTS_AND_ANALYTICS_TOP_SYNDICATIONS_DRILL_DOWN:String = "Users And Community Reports Tab>Top Syndications DrillDown";
		public static const REPORTS_AND_ANALYTICS_TOP_CONTENT:String = "Content Reports>Top Content";
		public static const REPORTS_AND_ANALYTICS_CONTENT_DROPOFF:String = "Content Reports>Content Drop-off";
		public static const REPORTS_AND_ANALYTICS_CONTENT_INTERACTIONS:String = "Content Reports>Content Interactions";
		public static const REPORTS_AND_ANALYTICS_CONTENT_CONTRIBUTIONS:String = "Content Reports>Content Contributions";
		public static const REPORTS_AND_ANALYTICS_CONTENT_CONTRIBUTIONS_DRILLDOWN:String = "Content Reports>Content Contributions DrillDown";
		public static const REPORTS_AND_ANALYTICS_VIDEO_DRILL_DOWN:String = "Content Reports>Video Drill Down";
		public static const REPORTS_AND_ANALYTICS_CONTENT_DRILL_DOWN_INTERACTION:String = "Content Reports>Content Drill Down Interaction";
		public static const REPORTS_AND_ANALYTICS_VIDEO_DRILL_DOWN_DROPOFF:String = "Content Reports>Video Drill Down Dropoff";



		// ==================================================================
		// module names:
		// ==================================================================
		public static const ANALYTICS:String = "KMC/Reports and Analytics";
		public static const CONTENT:String = "KMC/Content";
		public static const STUDIO:String = "KMC/Studio";
		public static const ACCOUNT:String = "KMC/Account";
		public static const DASHBOARD:String = "KMC/Dashboard";
		public static const ADMIN:String = "KMC/Administration";


	}
}