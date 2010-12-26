package com.kaltura.kmc.business
{
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
		public function testProtected():void {
			var d:int = stringIndex("a", ["a", "b","c"]);
			Assert.assertEquals(0, d);
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
		
	}
}