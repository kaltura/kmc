package com.kaltura.kmc.business {
	import com.kaltura.kmc.business.PermissionsParser;
	import com.kaltura.kmc.vo.PermissionVo;

	import flexunit.framework.Assert;

	import org.flexunit.asserts.assertEquals;

	public class TestPermissionParser extends PermissionsParser {


		private var test1:XML = <root>
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
					<!-- this module requires 4 of 5 boxes -->
					<module id="dashboard" min="4">
						<permission id="13"/>
						<permission id="STUDIO_BASE"/>
						<permission id="ANALYTICS_BASE"/>
						<permission id="CONTENT_INGEST_BASE"/>
						<permission id="32"/>
					</module>
				</uimapping>
			</root>;


		[Test]
		/**
		 * we deny all permissions needed for content.moderation subtab
		 * so it should be removed (appear in the returned list).
		 */
		public function testHideSingleSubTab():void {
			var permits:String = "CONTENT_INGEST_BASE,CONTENT_INGEST_UPLOAD,CONTENT_INGEST_BULK_UPLOAD,ANALYTICS_BASE,STUDIO_BASE,13,32";
			var tabs:Array = getTabsToHide(test1.uimapping[0], permits.split(","));
			Assert.assertEquals(1, tabs.length);
			Assert.assertEquals("content.moderation", tabs[0]);
		}


		[Test]
		/**
		 * we need Account > upgrade to always be available. test the module is
		 * not dropped even if all relevant action-permissions are not granted.
		 */
		public function testNoHideModule():void {
			var uimapping:XML = <uimapping>
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
					<module id="account">
						<tab id="upgrade">
							<permission id="UPGRADE_BASE"/>
						</tab>
						<tab id="overview">
							<permission id="ACCOUNT_BASE"/>
							<permission id="ACCOUNT_UPDATE_SETTINGS"/>
						</tab>
						<tab id="integration">
							<permission id="INTEGRATION_BASE"/>
							<permission id="INTEGRATION_UPDATE_SETTINGS"/>
						</tab>
						<tab id="accessControl">
							<permission id="ACCESS_CONTROL_BASE"/>
							<permission id="ACCESS_CONTROL_ADD"/>
							<permission id="ACCESS_CONTROL_UPDATE"/>
							<permission id="ACCESS_CONTROL_DELETE"/>
						</tab>
					</module>
				</uimapping>
			var permits:String = "ANALYTICS_BASE,STUDIO_BASE,13,32,UPGRADE_BASE";
			var tabs:Array = getTabsToHide(uimapping, permits.split(","));
			var result:Boolean = false;
			var n:int = tabs.length;
			for (var i:int = 0; i < n; i++) {
				if (tabs[i] == "account") {
					result = true;
					break;
				}
			}
			Assert.assertFalse(result);
		}


		[Test]
		/**
		 * we deny all permissions needed for content module (both tabs)
		 * so content module should be removed (appear in the returned list).
		 */
		public function testHideModule():void {
			var noPermits:String = "ANALYTICS_BASE,STUDIO_BASE,13,32";
			var tabs:Array = getTabsToHide(test1.uimapping[0], noPermits.split(","));
			Assert.assertEquals(3, tabs.length);
			var result:Boolean = false;
			var n:int = tabs.length;
			for (var i:int = 0; i < n; i++) {
				if (tabs[i] == "content") {
					result = true;
					break;
				}
			}
			Assert.assertTrue(result);
		}


		[Test]
		/**
		 * the dashboard module requires 4 out of 5 permissions to show.
		 * we only give 2, so it should be removed (appear in the returned list).
		 */
		public function testHideModuleMinTabs():void {
			var permits:String = "ANALYTICS_BASE,STUDIO_BASE";
			var tabs:Array = getTabsToHide(test1.uimapping[0], permits.split(","));
			var result:Boolean = false;
			var n:int = tabs.length;
			for (var i:int = 0; i < n; i++) {
				if (tabs[i] == "dashboard") {
					result = true;
					break;
				}
			}
			Assert.assertTrue(result);
		}


		[Test]
		/**
		 * the dashboard module requires 4 out of 5 permissions to show.
		 * we give 4, so it should not be removed (shouldn't appear
		 * in the returned list).
		 */
		public function testNoHideModuleMinTabs():void {
			var permits:String = "ANALYTICS_BASE,STUDIO_BASE,13,32";
			var tabs:Array = getTabsToHide(test1.uimapping[0], permits.split(","));
			var result:Boolean = false;
			var n:int = tabs.length;
			for (var i:int = 0; i < n; i++) {
				if (tabs[i] == "dashboard") {
					result = true;
					break;
				}
			}
			Assert.assertFalse(result);
		}


		[Test]
		/**
		 * analytics module has no tabs, we deny its permissions
		 * so it should be removed.
		 */
		public function testHideModuleWithNoTabs():void {
			var permits:String = "CONTENT_MODERATE_BASE,CONTENT_MODERATE_METADATA,CONTENT_INGEST_BASE,CONTENT_INGEST_UPLOAD,CONTENT_INGEST_BULK_UPLOAD,STUDIO_BASE,13,32";
			var tabs:Array = getTabsToHide(test1.uimapping[0], permits.split(","));
			Assert.assertEquals(1, tabs.length);
			Assert.assertEquals("analytics", tabs[0]);
		}


		[Test]
		/**
		 * test the util method that checks if a string is in a strings array.
		 * the string is in the array.
		 */
		public function testPermissionInPermissionArray():void {
			Assert.assertTrue(isStringInArray("Atar", ["Eitan", "Michal", "Hila", "Atar"]));
		}


		[Test]
		/**
		 * test the util method that checks if a string is in a strings array.
		 * the string is not in the array.
		 */
		public function testPermissionNotInPermissionArray():void {
			Assert.assertFalse(isStringInArray("Boaz", ["Eitan", "Michal", "Hila", "Atar"]));
		}


		/**
		 * The test checks the main parsing function  'parsePermissions'
		 */
		[Test]
		public function testParsePermissions():void {
			var permissionsArray:Array = super.parsePermissions(test1.permissions..permission);
			//array length
			Assert.assertEquals(permissionsArray.length, 8);
			//looking for 2 specific items in the array and checking their attributes: 
			for each (var o:PermissionVo in permissionsArray) {
				//check that content.playlist.createRulebasedBtn has 2 attributes + their values
				if (o.path == "content.playlist.createRulebasedBtn") {
					Assert.assertObjectEquals(o.attributes, {visible: "false", includeInLayout: "false"});

					// making sure that there are only 2 attributes, no more, no less
					var tmp:Number = 0;
					for (var j:Object in o.attributes) {
						tmp++;
					}
					Assert.assertEquals(tmp, 2);

				}
				// checking that this XML gives the instruction to remove the moderation tab
				if (o.path == "content.moderation") {
					if (o.attributes.hasOwnProperty("remove")) {
						Assert.assertEquals(o.attributes.remove, "true");
					}
				}
			}
		}


		/**
		 * This test check the inner function 'getInstructions'
		 */
		[Test]
		public function testGetInstructions():void {

			// one item - sub tab
			var instruction1:XML = <permission text="Moderation" id="4568">
					<ui id="content.moderation" remove="true" />
				</permission>;

			// two items - regular
			var instruction2:XML = <permission text="KCW" id="3321">
					<ui id="content.manage.createManualBtn" enabled="false" />
					<ui id="content.manage.createRulebasedBtn" visible="false" includeInLayout="false" />
					<ui id="content.manage.createRulebasedBtn.label" visible="false" includeInLayout="false" />
				</permission>;
			// no items 
			var instruction3:XML = <permission text="empty" id="3655">
				</permission>;

			var arr:Array = getInstructions(instruction1);
			Assert.assertObjectEquals(arr[0].attributes, {remove: 'true'});
			Assert.assertEquals(arr.length, 1);


			arr = getInstructions(instruction2);
			Assert.assertEquals(arr.length, 3);
			//TODO - check if this is OK to asume array order
			Assert.assertEquals(arr[0].path, "content.manage.createManualBtn");
			Assert.assertObjectEquals(arr[0].attributes, {enabled: 'false'});

			Assert.assertEquals(arr[1].path, "content.manage.createRulebasedBtn");
			Assert.assertObjectEquals(arr[1].attributes, {visible: 'false', includeInLayout: 'false'});

			Assert.assertEquals(arr[2].path, "content.manage.createRulebasedBtn.label");
			Assert.assertObjectEquals(arr[2].attributes, {visible: 'false', includeInLayout: 'false'});

			arr = getInstructions(instruction3);
			Assert.assertNull(arr[0]);

		}

	}
}