package com.kaltura.kmc.modules.admin.view
{
	public class TestRoleDrilldown extends RoleDrilldown
	{	
		
		
		
		
		protected var innerUiConf:XML = <root>
									  <permissions>
										<!-- -->
										<permissionGroup text="Content ingestion"
										id="CONTENT_INGEST_BASE">
										  <permission text="KCW" id="CONTENT_INGEST_UPLOAD">
										  </permission>
										  <permission text="Bulk upload"
										  id="CONTENT_INGEST_BULK_UPLOAD"></permission>
										  <permission text="create remix" id="CONTENT_INGEST_ADD_MIX">
										  </permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Content Management"
										id="CONTENT_MANAGE_BASE">
										  <permission text="modify metadata"
										  id="CONTENT_MANAGE_METADATA"></permission>
										  <permission text="modify categories"
										  id="CONTENT_MANAGE_ASSIGN_CATEGORIES"></permission>
										  <permission text="modify thumbnail"
										  id="CONTENT_MANAGE_THUMBNAIL"></permission>
										  <permission text="modify schedual"
										  id="CONTENT_MANAGE_SCHEDULE"></permission>
										  <permission text="modify modify access control profile"
										  id="CONTENT_MANAGE_ACCESS_CONTROL"></permission>
										  <permission text="delete content"
										  id="CONTENT_MANAGE_CUSTOM_DATA"></permission>
										  <permission text="grab embed code"
										  id="CONTENT_MANAGE_EMBED_CODE"></permission>
										  <permission text="reconvert flavors"
										  id="CONTENT_MANAGE_RECONVERT"></permission>
										  <permission text="manage live stream"
										  id="CONTENT_MANAGE_ADD_LIVE"></permission>
										  <permission text="edit categories"
										  id="CONTENT_MANAGE_EDIT_CATEGORIES"></permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Content Moderation"
											id="CONTENT_MODERATE_BASE">
										  <permission text="Moderate metadata"
										  id="CONTENT_MODERATE_METADATA"></permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Playlist management" id="PLAYLIST_BASE">
										  <permission text="create playlist" id="PLAYLIST_ADD">
										  </permission>
										  <permission text="modify playlist" id="PLAYLIST_UPDATE">
										  </permission>
										  <permission text="delete playlist" id="PLAYLIST_DELETE">
										  </permission>
										  <permission text="grab playlist embed code"
										  id="PLAYLIST_EMBED_CODE"></permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Syndication management"
										id="SYNDICATION_BASE">
										  <permission text="create syndication feeds"
										  id="SYNDICATION_ADD"></permission>
										  <permission text="modify syndication feeds"
										  id="SYNDICATION_UPDATE"></permission>
										  <permission text="delete syndication feeds"
										  id="SYNDICATION_DELETE"></permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Studio" id="STUDIO_BASE">
										  <permission text="create player" id="STUDIO_ADD_UICONF">
										  </permission>
										  <permission text="modify players" id="STUDIO_UPDATE_UICONF">
										  </permission>
										  <permission text="delete players" id="STUDIO_DELETE_UICONF">
										  </permission>
										  <permission text="Set advertising settings"
										  id="ADVERTISING_UPDATE_SETTINGS"></permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Account settings" id="ACCOUNT_BASE">
										  <permission text="account" 
											id="ACCOUNT_UPDATE_SETTINGS" />
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Integration settings"
										id="INTEGRATION_BASE">
										  <permission text="integration" 
										  id="INTEGRATION_UPDATE_SETTINGS" />
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Access control settings"
										id="ACCESS_CONTROL_BASE">
										  <permission text="Create" id="ACCESS_CONTROL_ADD">
										  </permission>
										  <permission text="modify" id="ACCESS_CONTROL_UPDATE">
										  </permission>
										  <permission text="delete" id="ACCESS_CONTROL_DELETE">
										  </permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Transcoding settings"
										id="TRANSCODING_BASE">
										  <permission text="Create" id="TRANSCODING_ADD"></permission>
										  <permission text="modify" id="TRANSCODING_UPDATE">
										  </permission>
										  <permission text="delete" id="TRANSCODING_DELETE">
										  </permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Custom data settings"
										id="CUSTOM_DATA_PROFILE_BASE">
										  <permission text="Create" id="CUSTOM_DATA_PROFILE_ADD">
										  </permission>
										  <permission text="modify" id="CUSTOM_DATA_PROFILE_UPDATE">
										  </permission>
										  <permission text="delete" id="CUSTOM_DATA_PROFILE_DELETE">
										  </permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Administration" id="ADMIN_BASE">
										  <permission text="Create users" id="ADMIN _USER_ADD">
										  </permission>
										  <permission text="modify users" id="ADMIN _USER_UPDATE">
										  </permission>
										  <permission text="delete users" id="ADMIN _USER_DELETE">
										  </permission>
										  <permission text="Create roles" id="ADMIN _ROLE_ADD">
										  </permission>
										  <permission text="modify roles" id="ADMIN _ROLE_UPDATE">
										  </permission>
										  <permission text="delete roles" id="ADMIN _ROLE_DELETE">
										  </permission>
										</permissionGroup>
										<!-- -->
										<permissionGroup text="Video Analytics" id="ANALYTICS_BASE">
										</permissionGroup>
										<!-- -->
									  </permissions>
									  
									  <!-- -->
									  <!-- -->
									  <!-- -->
									  
									  <uimapping>
										<module id="content">
										  <tab id="upload">
											<permission id="" />
											<permission id="" />
										  </tab>
										  <tab id="moderation">
											<permission id="" />
										  </tab>
										</module>
										<module id="analytics">
										  <permission id="44" />
										</module>
										<!-- this module requres 4 of 5 boxes -->
										<module id="dashboard" min="4">
										  <!-- embed player -->
										  <permission id="13" />
										  <!-- studio permission -->
										  <permission id="23" />
										  <!-- analytics permission -->
										  <permission id="44" />
										  <!-- upload permission -->
										  <permission id="2" />
										  <!-- account and billing permission -->
										  <permission id="32" />
										</module>
									  </uimapping>
									</root>;

		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
		
		
	}
}