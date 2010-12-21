package com.kaltura.kmc.business {
	import com.kaltura.kmc.business.PermissionManager;
	
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
			pm.init(test1);
		}
		
		

		[Test]
		/**
		 * try to get the modules that should be dropped
		 */
		public function testGetModulesToHide():void {
			var arr:Array = pm.getRelevantSubTabsToHide();
			Assert.assertEquals(3, arr.length);
		}
		

		[Test]
		/**
		 * test hideTabs
		 */
		public function testNumberOfTabsToHide():void {
			var arr:Array = pm.hideTabs;
			Assert.assertEquals(5, arr.length);
		}


		[Test]
		/**
		 * test permissions
		 */
		public function testNumberOfPermissions():void {
			var arr:Array = pm.deniedPermissions;
			Assert.assertEquals(9, arr.length);
		}


		[Test]
		/**
		 * test general creation of VOs
		 */
		public function testNumberOfInstructionVos():void {
			var arr:Array = pm.instructionVos;
			Assert.assertEquals(8, arr.length);
		}
		
		
		
		[Test]
		/**
		 * test that colliding attributes are removed from the denied list
		 * NOTE: this method tests the function below it, not the actual code!!
		 */
		public function testRemoveCollisions():void {
			var granted:XML = 	<permissions> 
									<permission text="Upload Files" id="CONTENT_INGEST_UPLOAD2">
										<ui id="content.upload.profilesCb" enabled="false"/>
									</permission>
									<permission text="Bulk Upload" id="CONTENT_INGEST_BULK_UPLOAD2">
										<ui id="dashboard.uploadPanel.uploadOption1Button" visible="false"/>
									</permission>
								</permissions>;
				
			var denied:XML = <permissions> 
						<permissionGroup text="Upload Files" id="CONTENT_INGEST_UPLOAD_BASE" hideGroup="true">
							<permission text="Upload Files" id="CONTENT_INGEST_UPLOAD">
								<ui id="content.upload.profilesCb" enabled="false"/>
								<ui id="content.upload.kcwBtn" enabled="false" buttonMode="false"/>
								<ui id="dashboard.uploadPanel.uploadOption2Button" enabled="false" buttonMode="false"/>
							</permission>
						</permissionGroup>
						<permissionGroup text="Bulk Upload" id="CONTENT_INGEST_BULK_UPLOAD_BASE" hideGroup="true">
							<permission text="Bulk Upload" id="CONTENT_INGEST_BULK_UPLOAD">
								<ui id="content.upload.submitBtn" enabled="false"/>
								<ui id="dashboard.uploadPanel.uploadOption1Button" enabled="false" buttonMode="false"/>
							</permission>
						</permissionGroup>
					</permissions>;
				
			removeCollisions(granted, denied);
			var ui:XML = denied..permission.(@id == 'CONTENT_INGEST_UPLOAD').ui.(@id == 'content.upload.profilesCb')[0];
			if (ui.attribute("enabled").length() > 0) {
				Assert.fail("attribute not removed");
			}	
			ui = denied..permission.(@id == 'CONTENT_INGEST_BULK_UPLOAD').ui.(@id == 'dashboard.uploadPanel.uploadOption1Button')[0];
			if (ui.attribute('visible').length() > 0) {
				Assert.fail("attribute added");
			}
			if (!ui.@enabled ) {
				Assert.fail("attribute removed");
			}	
			else if (ui.@enabled != "false") {
				Assert.fail("attribute value changed");
			}
		}
		
		/**
		 * remove the attributes on ui nodes that have values on both the granted and denied lists.
		 * this method alters the denied list. 
		 * @param granted	permissions that the user has
		 * @param denied	permissions that the user doesn't have
		 */
		protected function removeCollisions(granted:XML, denied:XML):void {
			var grantedui:XMLList = granted..ui;
			var gl:int = grantedui.length();
			var deniedui:XMLList = denied..ui;
			var dl:int = deniedui.length();
			var uiid:String;
			var atts:XMLList;
			for (var i:int =0; i< gl; i++) {
				uiid = grantedui[i].@id;
				for each (var uixml:XML in deniedui) {
					if (uixml.@id == uiid) {
						// remove the matching attributes from the denied permission
						atts = grantedui[i].attributes();
						for (var j:int = 0; j<atts.length(); j++) {
							if (atts[j].localName() != "id" && uixml.attribute(atts[j].localName())) {
								delete uixml.@[atts[j].localName()];
							}
						}
					}
				}
			}
		}
	}
}