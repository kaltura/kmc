package com.kaltura.analytics {

	public class GoogleAnalyticsConsts {
		public static const PAGE_VIEW:String = "Page view/";
		public static const ACTION:String = "Action/";
		public static const CLIENT_POST_TIMEOUT:String = "ClientPostTimeout";
		public static const CLIENT_CONNECTION_TIMEOUT:String = "ClientConnectionTimeout";
		
		
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
		// page views
		// ==============================
		public static const CONTENT_ENTRIES:String = "Entries";
		public static const CONTENT_MODERATION:String = "Moderation";
		public static const CONTENT_PLAYLISTS:String = "Playlists";
		public static const CONTENT_SYNDICATION:String = "Syndication";
		public static const CONTENT_CATEGORIES:String = "Categories";
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
		public static const CONTENT_CAT_DRILLDOWN_METADATA:String = "Category DrillDown/Metadata";
		public static const CONTENT_CAT_DRILLDOWN_ENTITLEMENTS:String = "Category DrillDown/Entitlements";
		public static const CONTENT_CAT_DRILLDOWN_SUBCATS:String = "Category DrillDown/Subcategories";
		
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
		public static const CONTENT_DELETE_MEDIA_ENTRY:String = "Delete Entry";
		
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
		 * add tags to multiple entries
		 */
		public static const CONTENT_ADD_TAGS:String = "Add tags Multiple Entries"; 
		
		/**
		 * add tags to multiple categories
		 */
		public static const CONTENT_ADD_CATEGORY_TAGS:String = "Categories/Add tags Multiple Categories"; 
		
		/**
		 * remove tags from Multiple Entries 
		 */
		public static const CONTENT_REMOVE_TAGS:String = "Remove Tags Multiple Entries"; 
		
		/**
		 * remove tags from Multiple categories 
		 */
		public static const CONTENT_REMOVE_CATEGORY_TAGS:String = "Categories/Remove Tags Multiple Categories"; 
		
		/**
		 * create new category 
		 */
		public static const CONTENT_ADD_CATEGORY:String = "Categories/Add Category";
		
		/**
		 * delete existing category (single)
		 */
		public static const CONTENT_DELETE_CATEGORY:String = "Categories/Delete Category"; 
		
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

		// Thumbnail actions:
		public static const CONTENT_DRILLDOWN_THUMBNAIL_ADD:String = "DrillDown/Add Thumbnail"; 
		public static const CONTENT_DRILLDOWN_THUMBNAIL_DEFAULT:String = "DrillDown/Set Default Thumbnail"; 
		public static const CONTENT_DRILLDOWN_THUMBNAIL_DELETE:String = "DrillDown/Delete Thumbnail"; 
		public static const CONTENT_DRILLDOWN_THUMBNAIL_DNLD:String = "DrillDown/Download Thumbnail";
		
		// Flavor actions:
		public static const CONTENT_DRILLDOWN_FLAVOR_DELETE:String = "DrillDown/Delete Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_DNLD:String = "DrillDown/Download Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_UPLOAD:String = "DrillDown/Upload Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_LINK:String = "DrillDown/Link Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_IMPORT:String = "DrillDown/Import Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_MATCH:String = "DrillDown/Match Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_PREVIEW:String = "DrillDown/Preview Flavor"; 
		public static const CONTENT_DRILLDOWN_FLAVOR_CONVERT:String = "DrillDown/Convert Flavor";
		public static const CONTENT_DRILLDOWN_FLAVOR_WV_DETAILS:String = "DrillDown/view DRM details";
		
		// replace media actions
		public static const CONTENT_DRILLDOWN_FLAVORS_UPLOAD:String = "DrillDown/Replace Content>Upload"; 
		public static const CONTENT_DRILLDOWN_FLAVORS_IMPORT:String = "DrillDown/Replace Content>Import"; 
		public static const CONTENT_DRILLDOWN_FLAVORS_LINK:String = "DrillDown/Replace Content>Link"; 
		public static const CONTENT_DRILLDOWN_FLAVORS_MATCH:String = "DrillDown/Replace Content>Match"; 
		public static const CONTENT_DRILLDOWN_FLAVORS_APPROVE:String = "DrillDown/Replace Content>Approve Replacement"; 
		public static const CONTENT_DRILLDOWN_FLAVORS_REJECT:String = "DrillDown/Replace Content>Reject Replacement"; 

		// Captions actions:
		public static const CONTENT_DRILLDOWN_CAPTIONS_ADD:String = "DrillDown/Add Caption"; 
		public static const CONTENT_DRILLDOWN_CAPTIONS_DEFAULT:String = "DrillDown/Set Default Captions"; 
		public static const CONTENT_DRILLDOWN_CAPTIONS_DELETE:String = "DrillDown/Delete Captions"; 
		public static const CONTENT_DRILLDOWN_CAPTIONS_DNLD:String = "DrillDown/Download Captions";

		// Related Files actions:
		public static const CONTENT_DRILLDOWN_RELATED_ADD:String = "DrillDown/Add Related File"; 
		public static const CONTENT_DRILLDOWN_RELATED_EDIT:String = "DrillDown/Edit Related File"; 
		public static const CONTENT_DRILLDOWN_RELATED_DELETE:String = "DrillDown/Delete Related File"; 
		public static const CONTENT_DRILLDOWN_RELATED_DNLD:String = "DrillDown/Download Related File";
		
		
		// categories actions
		// ==============================
		/**
		 * delete multiple categories (in bulk)  
		 */		
		public static const CONTENT_CATS_DELETE_BULK:String = "Categories/Delete Multiple Categories";
		
		/**
		 * move categories (single / multiple)
		 */
		public static const CONTENT_CATS_MOVE:String = "Categories/Move Categories";
		
		/**
		 * change multiple categories access
		 */
		public static const CONTENT_CATS_ACCESS:String = "Categories/Change Categories Access";
		
		/**
		 * change multiple categories listing
		 */
		public static const CONTENT_CATS_LISTING:String = "Categories/Change Categories Listing";
		
		/**
		 * change multiple categories contribution policy
		 */
		public static const CONTENT_CATS_CONTRIBUTION_POLICY:String = "Categories/Change Categories Contribution Policy";
		
		/**
		 * change multiple categories owner
		 */
		public static const CONTENT_CATS_OWNER:String = "Categories/Change Categories Owner";
		
		
		// ==================================================================
		// account settings:
		// ==================================================================
		// page views
		// ==============================
		public static const ACCOUNT_ACCOUNT_INFO:String = "Account Info";
		public static const ACCOUNT_INTEGRATION:String = "Integration";
		public static const ACCOUNT_ACCESS_CONTROL:String = "Access Control";
		public static const ACCOUNT_TRANSCODING_SETTINGS:String = "Transcoding Settings";
		public static const ACCOUNT_CUTOM_DATA:String = "Custom Data";
		public static const ACCOUNT_MY_USER:String = "My User Settings";
		public static const ACCOUNT_ACCOUNT_UPGRADE:String = "Account Upgrade";
		
		// actions
		// ==============================
		
		/**
		 * click "save" on account info page 
		 */
		public static const ACCOUNT_CHANGE_PARTNER_INFO:String = "Update Partner Info";
		
		
		/**
		 * click on "send" in contact us page 
		 */
		public static const ACCOUNT_CONTACT_US_USAGE:String = "Contact Us Usage"; 
		
		/**
		 * click "save" on integration settings 
		 */
		public static const ACCOUNT_UPDATE_INTEGRATION:String = "Update Integration Settings";
		
		/**
		 * access control profile deleted 
		 */		
		public static const ACCOUNT_ACCESS_CONTROL_DELETE:String = "Access Control Delete";
		
		/**
		 * click "save" on default conversion profile page 
		 */
		public static const ACCOUNT_SAVE_DEF_TRANSCODING_PROF:String = "Save Default Transcoding Profile";
		
		
		// ==================================================================
		// dashboard:
		// ==================================================================
		// actions
		// ==============================
		/**
		 * request upload files
		 */
		public static const DASHBOARD_UPLOAD_CONTENT:String = "Upload Content";
		
		/**
		 * request bulk upload 
		 */
		public static const DASHBOARD_IMPORT_CONTENT:String = "Import Content";

		/**
		 * request bulk samples 
		 */
		public static const DASHBOARD_DNLD_SAMPLES:String = "Download Bulk Samples";
		
		/**
		 * click on "contect us" link 
		 */
		public static const DASHBOARD_ACCOUNT_CONTACT_US:String = "Contact Us";
		
		/**
		 * go to analytics page
		 */
		public static const DASHBOARD_VIEW_REPORTS:String = "View Reports";
		
		/**
		 * go to content tab 
		 */		
		public static const DASHBOARD_EMBED_PLAYER:String = "Embed player";
		
		/**
		 * go to playlists tab
		 */
		public static const DASHBOARD_EMBED_PLAYLIST:String = "Embed PlayList";
		
		/**
		 * go to studio 
		 */
		public static const DASHBOARD_CUSTOMIZE_PLAYERS:String = "Customize Players";

		// ==================================================================
		// Login screen (NOT in KMC):
		// ==================================================================
		public static const LOGIN:String = "User Logs In"; 
		public static const LOGIN_FIRST_TIME:String = "login first time"; 


		// ==================================================================
		// studio:
		// ==================================================================
		// page views
		// ==============================
		public static const STUDIO_WIZARD_BASICS:String = "Wizard/Basics";
		public static const STUDIO_WIZARD_FEATURES:String = "Wizard/Features";
		public static const STUDIO_WIZARD_ADS:String = "Wizard/Advertising";
		public static const STUDIO_WIZARD_STYLE:String = "Wizard/Style";
		public static const STUDIO_WIZARD_CONTENT:String = "Wizard/Content";
		
		// actions
		// ==============================
		public static const STUDIO_NEW_PLAYER:String = "New Player";
//		public static const STUDIO_NEW_PLAYER_SINGLE_VIDEO:String = "New Player Single Video";
//		public static const STUDIO_NEW_PLAYER_PLAYLIST:String = "New Player Playlist";
//		public static const STUDIO_NEW_PLAYER_MULTI_TAB_PLAYLIST:String = "New Player Multitab Playlist";
//		public static const STUDIO_NEW_PLAYER_508:String = "New 508 Player";
		public static const STUDIO_EDIT_PLAYER:String = "Edit Player";
		public static const STUDIO_DUPLICATE_PLAYER:String = "Duplicate Player";
		public static const STUDIO_DELETE_PLAYER:String = "Delete Player";
		public static const STUDIO_SELECT_CONTENT:String = "Select Player Content";
		public static const STUDIO_PNE:String = "Preview and Embed";

		
		// ==================================================================
		// analytics:
		// ==================================================================
		// page views
		// ==============================
		public static const ANALYTICS_REAL_TIME:String = "RealTime Reports";
		public static const ANALYTICS_LIVE:String = "Live Reports";
		public static const ANALYTICS_PLATFORM:String = "Platform Reports";
		public static const ANALYTICS_BANDWIDTH_USAGE:String = "BandWidth Usage";
		public static const ANALYTICS_CONTENT_REPORTS:String = "Content Reports";
		public static const ANALYTICS_USERS_AND_COMMUNITY_REPORTS:String = "Users And Community Reports";
		
		// actions
		// ==============================
//		public static const ANALYTICS_BANDWIDTH_USAGE_VIEW_MONTHLY:String = "BandWidth Usage view Monthly";
//		public static const ANALYTICS_BANDWIDTH_USAGE_VIEW_YEARLY:String = "BandWidth Usage view Yearly";
	
		public static const ANALYTICS_PARTNER_USAGE_REPORTS:String = "BandWidth Usage>Publisher Bandwidth and Storage Report";
		public static const ANALYTICS_USER_USAGE_REPORTS:String = "BandWidth Usage>End Users Storage Report";
		public static const ANALYTICS_SPECIFIC_USER_USAGE_REPORTS:String = "BandWidth Usage>Specific End User Storage Report";
		
		public static const ANALYTICS_TOP_CONTRIBUTORS:String = "Users And Community Reports>Top Contributors";
		public static const ANALYTICS_MAP_OVERLAYS:String = "Users And Community Reports>Geographic Distribution";
		public static const ANALYTICS_MAP_OVERLAYS_DRILLDOWN:String = "Users And Community Reports>Geographic Distribution DrillDown";
		public static const ANALYTICS_TOP_SYNDICATIONS:String = "Users And Community Reports>Top Syndications";
		public static const ANALYTICS_TOP_SYNDICATIONS_DRILL_DOWN:String = "Users And Community Reports>Top Syndications DrillDown";
		public static const ANALYTICS_USER_ENGAGEMENT:String = "Users And Community Reports>User Engagement";
		public static const ANALYTICS_USER_ENGAGEMEN_DRILL_DOWN:String = "Users And Community Reports>User Engagement DrillDown";
		
		public static const ANALYTICS_TOP_CONTENT:String = "Content Reports>Top Content";
		public static const ANALYTICS_CONTENT_DROPOFF:String = "Content Reports>Content Drop-off";
		public static const ANALYTICS_CONTENT_INTERACTIONS:String = "Content Reports>Content Interactions";
		public static const ANALYTICS_CONTENT_CONTRIBUTIONS:String = "Content Reports>Content Contributions";
		public static const ANALYTICS_CONTENT_CONTRIBUTIONS_DRILLDOWN:String = "Content Reports>Content Contributions DrillDown";
		public static const ANALYTICS_VIDEO_DRILL_DOWN:String = "Content Reports>Video Drill Down";
		public static const ANALYTICS_CONTENT_DRILL_DOWN_INTERACTION:String = "Content Reports>Content Drill Down Interaction";
		public static const ANALYTICS_VIDEO_DRILL_DOWN_DROPOFF:String = "Content Reports>Video Drill Down Dropoff";
		
		
		public static const ANALYTICS_PLATFORM_PLATFORMS:String = "Platform Reports>Platforms";
		public static const ANALYTICS_PLATFORM_PLATFORMS_DRILL_DOWN:String = "Platform Reports>Platform DrillDown";
		public static const ANALYTICS_PLATFORM_OS:String = "Platform Reports>Operating Systems";
		public static const ANALYTICS_PLATFORM_BROWSERS:String = "Platform Reports>Browsers";
		

		// ==================================================================
		// administration:
		// ==================================================================
		// page views
		// ==============================
		public static const ADMIN_USERS:String = "Users";
		public static const ADMIN_ROLES:String = "Roles";
		
		// actions
		// ==============================
		public static const ADMIN_USER_ADD:String = "Add User";
		public static const ADMIN_USER_EDIT:String = "Edit User";
		public static const ADMIN_USER_BLOCK:String = "Block User";
		public static const ADMIN_USER_UNBLOCK:String = "Unblock User";
		public static const ADMIN_USER_DELETE:String = "Delete User";
		public static const ADMIN_ROLE_ADD:String = "Add Role";
		public static const ADMIN_ROLE_EDIT:String = "Edit Role";
		public static const ADMIN_ROLE_DELETE:String = "Delete Role";
		public static const ADMIN_ROLE_DUPLICATE:String = "Duplicate Role";
		
		
		// ==================================================================
		// module names:
		// ==================================================================
		public static const ANALYTICS:String = "KMC/Reports and Analytics";
		public static const CONTENT:String = "KMC/Content";
		public static const STUDIO:String = "KMC/Studio";
		public static const ACCOUNT:String = "KMC/Settings";
		public static const DASHBOARD:String = "KMC/Dashboard";
		public static const ADMIN:String = "KMC/Administration";


	}
}