package com.kaltura.kmc.business.permissions {
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.vo.KalturaPermissionListResponse;
	
	import flexunit.framework.Assert;

	public class TestPermissionManager {

		private static var test1:XML = <root>
				<permissions>
					<permissionGroup text="Playlist Management" id="PLAYLIST_BASE">
						<permission text="Create Playlists" id="PLAYLIST_ADD">
							<ui id="content.playlist.createManualBtn" enabled="false" />
							<ui id="content.playlist.createRulebasedBtn" visible="false" includeInLayout="false" />
							<ui id="content.manage.entriesList.controlBar.playlistComboBox" visible="false" includeInLayout="false" />
						</permission>
						<permission text="Delete Playlists" id="PLAYLIST_DELETE">
							<ui id="content.playlist.DeleteBtn" visible="false" />
						</permission>
					</permissionGroup>
					<permissionGroup text="Content Ingestion" id="CONTENT_INGEST_BASE">
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
					<permissionGroup text="Video Analytics" id="ANALYTICS_BASE" />
				</permissions>
				
				<partnerPermissions/>

				<uimapping>
					<module id="content">
						<tab id="upload">
							<permission id="CONTENT_INGEST_BASE" />
							<permission id="CONTENT_INGEST_UPLOAD" />
							<permission id="CONTENT_INGEST_BULK_UPLOAD" />
						</tab>
						<tab id="moderation">
							<permission id="CONTENT_MODERATE_BASE" />
							<permission id="CONTENT_MODERATE_METADATA" />
						</tab>
					</module>
					<module id="analytics">
						<permission id="ANALYTICS_BASE" />
					</module>
					<!-- this module requres 4 of 5 boxes -->
					<module id="dashboard" min="4">
						<!-- embed player -->
						<permission id="13"/>
						<!-- studio permission -->
						<permission id="STUDIO_BASE"/>
						<!-- analytics permission -->
						<permission id="ANALYTICS_BASE"/>
						<!-- upload permission -->
						<permission id="CONTENT_INGEST_BASE"/>
						<!-- account and billing permission -->
						<permission id="32"/>
					</module>
				</uimapping>
			</root>;

		private static var pm:PermissionManager;

		

		[BeforeClass]
		public static function setUp():void {
			pm = PermissionManager.getInstance();
			pm.init(test1, 'CONTENT_INGEST_BASE,CONTENT_INGEST_UPLOAD,CONTENT_INGEST_BULK_UPLOAD,ANALYTICS_BASE', new KalturaPermissionListResponse());
		}
		
		

		[Test]
		/**
		 * try to get the modules that should be dropped
		 */
		public function testGetModulesToHide():void {
			var arr:Array = pm.getRelevantSubTabsToHide();
			Assert.assertEquals(1, arr.length);
		}
		
		[Test]
		/**
		 * test hideTabs
		 */
		public function testNumberOfTabsToHide():void {
			var arr:Array = pm.hideTabs;
			Assert.assertEquals(2, arr.length);
		}

		[Test]
		/**
		 * test permissions
		 */
		public function testNumberOfPermissions():void {
			var arr:Array = pm.deniedPermissions;
			Assert.assertEquals(5, arr.length);
		}

		[Test]
		/**
		 * test general creation of VOs
		 */
		public function testNumberOfInstructionVos():void {
			var arr:Array = pm.instructionVos;
			Assert.assertEquals(4, arr.length);
		}
		
	}
}