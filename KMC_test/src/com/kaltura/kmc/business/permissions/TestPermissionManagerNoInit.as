package com.kaltura.kmc.business.permissions {
	import com.kaltura.vo.KalturaPermissionListResponse;
	
	import flexunit.framework.Assert;
	import com.kaltura.kmc.business.PermissionManager;

	public class TestPermissionManagerNoInit {


		[Test]
		/**
		 * test initialization with a permissions that doesn't exist
		 * (running this test causes the others to fail because of the input)
		 */
		public function testIgnoreNonexistingPermission():void {
			var test1:XML = <root>
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
						<module id="dashboard" min="4">
							<permission id="13"/>
							<permission id="STUDIO_BASE"/>
							<permission id="ANALYTICS_BASE"/>
							<permission id="CONTENT_INGEST_BASE"/>
							<permission id="32"/>
						</module>
					</uimapping>
				</root>;
			PermissionManager.getInstance().init(test1, "atar", new KalturaPermissionListResponse());
		}

	}
}

