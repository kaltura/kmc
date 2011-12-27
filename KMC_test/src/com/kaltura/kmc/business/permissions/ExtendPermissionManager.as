package com.kaltura.kmc.business.permissions
{
	import com.kaltura.edw.business.permissions.PermissionManager;
	import com.kaltura.vo.KalturaPermission;
	import com.kaltura.vo.KalturaPermissionListResponse;
	
	import org.flexunit.Assert;

	public class ExtendPermissionManager extends PermissionManager
	{		
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
		
		[Test]
		public function testGetPartnerPermissionsUi():void {
			var partnerPermissionsListResult:KalturaPermissionListResponse = new KalturaPermissionListResponse();
			var perms:Array = new Array();
			var perm:KalturaPermission = new KalturaPermission();
			perm.id = 1;
			perm.name = "METADATA_PLUGIN_PERMISSION";
			perms.push(perm);
			//<item><id>1</id><name>METADATA_PLUGIN_PERMISSION</name><friendlyName>metadata Plugin</friendlyName><description>Permission to use metadata plugin</description><status>1</status><partnerId>569</partnerId><createdAt>1292842684</createdAt><updatedAt>1292842684</updatedAt></item>
//			perm = new KalturaPermission();
//			perm.id = 5;
//			perm.name = "FEATURE_VAST";
//			perms.push(perm);
			//<item><objectType>KalturaPermission</objectType><id>5</id><name>FEATURE_VAST</name><friendlyName>VAST feature</friendlyName><description>Permission to use VAST</description><status>1</status><partnerId>569</partnerId><createdAt>1292842685</createdAt><updatedAt>1292842685</updatedAt></item>
			perm = new KalturaPermission();
			perm.id = 6;
			perm.name = "FEATURE_LIVE_STREAM";
			perms.push(perm);
			//<item><objectType>KalturaPermission</objectType><id>6</id><name>FEATURE_LIVE_STREAM</name><friendlyName>Live stream feature</friendlyName><description>Permission to use live stream</description><status>1</status><partnerId>569</partnerId><createdAt>1292842685</createdAt><updatedAt>1292842685</updatedAt></item>
			partnerPermissionsListResult.objects = perms;
			
			var uidef:XML = <partnerPermissions>
		<permissionGroup id="METADATA_PLUGIN_PERMISSION">
			<ui id="content.generalPermissions" enableCustomData="false"/>
		</permissionGroup>
		<permissionGroup id="FEATURE_VAST">
			<ui id="wizard" hideTabs="advertizingPage"/>
		</permissionGroup>
	</partnerPermissions>;
			var result:XMLList = getPartnerPermissionsUi(uidef, partnerPermissionsListResult);
			var expectedString:XML = <permissionGroup id="FEATURE_VAST"><ui id="wizard" hideTabs="advertizingPage"/></permissionGroup>;
			
			Assert.assertEquals(expectedString, result);
		}
		
		[Test]
		public function testProtected():void {
			var d:int = stringIndex("a", ["a", "b","c"]);
			Assert.assertEquals(0, d);
		}
		
		[Test]
		/**
		 * test that colliding attributes are removed from the denied list
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
		
		[Test]
		/**
		 * test removing of role permissions which depend on missing partner permissions (features). 
		 */
		public function testRemoveRestrictedPermissions():void {
			var uiDefinitions:XML = <permissions><permissionGroup text="Content Moderation" id="CONTENT_MODERATE_BASE">
			<permission text="Moderate metadata" id="CONTENT_MODERATE_METADATA">
				<ui id="entryDrilldown.entryMetaData.name_input" editable="false"/>
				<ui id="entryDrilldown.entryMetaData.descriptionTi" editable="false"/>
				<ui id="entryDrilldown.entryMetaData.tagsTi" editable="false"/>
			</permission>
			<permission text="Moderate custom metadata" id="CONTENT_MODERATE_CUSTOM_DATA" dependsOnFeature="METADATA_PLUGIN_PERMISSION">
				<ui id="entryDrilldown.customData.all" enabled="false"/>
			</permission>
		</permissionGroup></permissions>;
			var rolePermissions:Array = "CONTENT_MODERATE_BASE,CONTENT_MODERATE_METADATA,CONTENT_MODERATE_CUSTOM_DATA".split(",");
			
			var partnerPermissions:KalturaPermissionListResponse = new KalturaPermissionListResponse();
			
			var ar:Array = removeRestrictedPermissions(uiDefinitions, rolePermissions, partnerPermissions);
			
			var CONTENT_MODERATE_METADATA:Boolean = false;
			var CONTENT_MODERATE_BASE:Boolean = false;
			
			for each (var str:String in ar) {
				if (str == 'CONTENT_MODERATE_CUSTOM_DATA') {
					Assert.fail('failed to remove CONTENT_MODERATE_CUSTOM_DATA');
				}
				if (str == 'CONTENT_MODERATE_METADATA') {
					CONTENT_MODERATE_METADATA = true;
				}
				if (str == 'CONTENT_MODERATE_BASE') {
					CONTENT_MODERATE_BASE = true;
				}
			}
			Assert.assertTrue(CONTENT_MODERATE_METADATA);
			Assert.assertTrue(CONTENT_MODERATE_BASE);
		}
		
	}
}