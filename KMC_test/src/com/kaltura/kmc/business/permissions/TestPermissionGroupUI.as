package com.kaltura.kmc.business.permissions
{
	import com.kaltura.kmc.business.PermissionManager;
	import com.kaltura.vo.KalturaPermissionListResponse;
	
	import flexunit.framework.Assert;

	/**
	 * Test the option of adding ui elements directly on permissions group element (no permission element)  
	 * @author Atar
	 */	
	public class TestPermissionGroupUI
	{		
		
		private static var pm:PermissionManager;
		private static var test1:XML = <root>
						<permissions>
							<permissionGroup text="Playlist Management" id="PLAYLIST_BASE">
								<ui id="content.playlist.create" enabled="false" />
								<permission text="Create Playlists" id="PLAYLIST_ADD">
									<ui id="content.playlist.createManualBtn" enabled="false" />
									<ui id="content.playlist.createRulebasedBtn" visible="false" includeInLayout="false" />
									<ui id="content.manage.entriesList.controlBar.playlistComboBox" visible="false" includeInLayout="false" />
								</permission>
								<permission text="Delete Playlists" id="PLAYLIST_DELETE">
									<ui id="content.playlist.DeleteBtn" visible="false" />
								</permission>
							</permissionGroup>
			
							<!--permissionGroup text="Content Ingestion" id="CONTENT_INGEST_BASE">
								<permission text="KCW" id="CONTENT_INGEST_UPLOAD">
									<ui id="content.manage.createManualBtn" enabled="false" />
									<ui id="content.manage.createRulebasedBtn" visible="false" includeInLayout="false" />
								</permission>
								<permission text="Bulk Upload" id="CONTENT_INGEST_BULK_UPLOAD">
									<ui id="content.playlist.DeleteBtn" visible="false" />
								</permission>
							</permissionGroup>
							<permissionGroup text="Content Moderation" id="CONTENT_MODERATE_BASE">
								<permission text="Moderate metadata" id="CONTENT_MODERATE_METADATA">
									<ui id="entryDrilldown.entryMetaData.name_input" editable="false"/>
								</permission>
							</permissionGroup>
							<permissionGroup text="Video Analytics" id="ANALYTICS_BASE" /-->
						</permissions>
						
						<partnerPermissions/>
		
						<uimapping />
							
					</root>;
		
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
			pm = PermissionManager.getInstance();
			pm.init(test1, 'PLAYLIST_BASE,PLAYLIST_ADD', new KalturaPermissionListResponse());
		}
		
		
		[Test]
		public function testGroupUI():void {
			var arr:Array = pm.instructionVos;
			Assert.assertEquals(1, arr.length);
		}
	}
}