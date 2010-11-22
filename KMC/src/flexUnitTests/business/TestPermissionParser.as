package flexUnitTests.business
{
	import com.kaltura.kmc.business.PermissionsParser;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	
	public class TestPermissionParser extends PermissionsParser
	{	
		
		
		private	var test1:XML = <root>
							  <permissions>
							    <permissionGroup text="Playlist Management">
							      <permission text="Create Playlists" id="6658">
							        <ui id="content.playlist.createManualBtn"
							        enabled="false" />
							        <ui id="content.playlist.createRulebasedBtn"
							        visible="false" includeInLayout="false" />
							        <ui id="content.manage.entriesList.controlBar.playlistComboBox"
							        visible="false" includeInLayout="false" />
							      </permission>
							      <permission text="Delete Playlists" id="6822">
							        <ui id="content.playlist.DeleteBtn" visible="false" />
							      </permission>
							    </permissionGroup>
							    <permissionGroup text="Content Ingestion">
							      <permission text="KCW" id="3321">
							        <ui id="content.manage.createManualBtn"
							        enabled="false" />
							        <ui id="content.manage.createRulebasedBtn"
							        visible="false" includeInLayout="false" />
							      </permission>
							      <permission text="Bulk Upload" id="3322">
							        <ui id="content.playlist.DeleteBtn" visible="false" />
							      </permission>
							    </permissionGroup>
							    <permissionGroup text="Content Moderation">
							      <permission text="Moderation" id="4568">
							        <ui id="content.moderation" remove="true" />
							      </permission>
							    </permissionGroup>
							    <permissionGroup text="Video Analytics">
							      <permission text="analytics" hide="true" id="4534" />
							    </permissionGroup>
							  </permissions>
							  <uimapping>
							    <module id="content">
							      <tab id="upload">
							        <permission id="3321" />
							        <permission id="3322" />
							      </tab>
							      <tab id="moderation">
							        <permission id="4568" />
							      </tab>
							    </module>
							    <module id="analytics">
							      <permission id="4534" />
							    </module>
							  </uimapping>
							</root>
							;
		
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
		
		[Ignore][Test]
		public function testGetTabsToHide():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		/**
		 * The test checks the main parsing function  'parsePermissions'
		 */
		[Test]
		public function testParsePermissions():void
		{
			var permissionsArray: Array = super.parsePermissions(test1);
			//array length
			Assert.assertEquals(permissionsArray.length, 8);
			//looking for 2 specific items in the array and checking their attributes: 
			for each (var o:Object in permissionsArray)
			{
				//check that content.playlist.createRulebasedBtn has 2 attributes + their values
				if(o.path == "content.playlist.createRulebasedBtn")
				{
					Assert.assertObjectEquals(o.attributes, {visible:"false", includeInLayout:"false"});
					
					// making sure that there are only 2 attributes, no more, no less
					var tmp:Number = 0;
					for (var j:Object in o.attributes)
					{
						tmp++;
					}
					Assert.assertEquals(tmp,2);
						
				}
				// checking that this XML gives the instruction to remove the moderation tab
				if(o.path == "content.moderation")
				{
					if (o.attributes.hasOwnProperty("remove") ) 
					{
						Assert.assertEquals(o.attributes.remove,"true");
					}
				}
			}
		}
		/**
		 * This test check the inner function 'getInstructions'  
		 */		
		[Test]
		public function testGetInstructions():void
		{
			
			// one item - sub tab
			var instruction1:XML = <permission text="Moderation" id="4568">
							        <ui id="content.moderation" remove="true" />
							      </permission> ;
			
			// two items - regular
			var instruction2:XML = <permission text="KCW" id="3321">
							        <ui id="content.manage.createManualBtn"
							        	enabled="false" />
							        <ui id="content.manage.createRulebasedBtn"
							        	visible="false" includeInLayout="false" />
							        <ui id="content.manage.createRulebasedBtn.label"
							        	visible="false" includeInLayout="false" />
							      </permission> ;
			// no items 
			var instruction3:XML = <permission text="empty" id="3655">
							      </permission> ;
			

			
			var arr:Array = getInstructions(instruction1);
			Assert.assertObjectEquals(arr[0].attributes,{remove:'true'});
			Assert.assertEquals(arr.length,1);
			
			
			arr = getInstructions(instruction2);
			Assert.assertEquals(arr.length,3);
			//TODO - check if this is OK to asume array order
			Assert.assertEquals(arr[0].path,"content.manage.createManualBtn");
			Assert.assertObjectEquals(arr[0].attributes,{enabled:'false'});
			
			Assert.assertEquals(arr[1].path,"content.manage.createRulebasedBtn");
			Assert.assertObjectEquals(arr[1].attributes,{visible:'false',includeInLayout:'false'});
			
			Assert.assertEquals(arr[2].path,"content.manage.createRulebasedBtn.label");
			Assert.assertObjectEquals(arr[2].attributes,{visible:'false',includeInLayout:'false'});
			
			arr = getInstructions(instruction3);
			Assert.assertNull(arr[0]);
			


		}
	}
}