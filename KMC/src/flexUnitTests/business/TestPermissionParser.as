package flexUnitTests.business
{
	import com.kaltura.kmc.business.PermissionsParser;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	
	public class TestPermissionParser extends PermissionsParser
	{		
		private var _permissionsPArser:PermissionsParser;
		[Before]
		public function setUp():void
		{
			_permissionsPArser = new PermissionsParser();
		}
		
		[After]
		public function tearDown():void
		{
			_permissionsPArser = null;
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
		public function testGetTabsToHide():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testParsePermissions():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetInstructionsWithUI():void
		{
			var xml:XML = <permission text="Create Playlists" id="6658">
				<ui id="content.playlist.createManualBtn" enabled="false"/>
				<ui id="content.playlist.createRulebasedBtn" visible="false"
					includeInLayout="false"/>
				<ui id="content.manage.entriesList.controlBar.playlistComboBox"
					visible="false" includeInLayout="false"/>
			</permission>;
			var arr:Array = getInstructions(xml);
			// we got 3 objects:
			Assert.assertEquals(arr.length, 3);
			// the 2nd object's contents:
			Assert.assertEquals(arr[1].path, "content.playlist.createRulebasedBtn");
			
			Assert.assertObjectEquals(arr[1].attributes, {visible:"false", includeInLayout:"false"});
		}
		
//		[Test]
//		public function testGetInstructionsWithoutUI():void
//		{
//			var xml:XML = <permission text="analytics" hide="true" id="4534"/>;
//			var arr:Array = _permissionsPArser.getInstructions(xml);
//			// we got 3 objects:
//			Assert.assertEquals(arr.length, 3);
//			// the 2nd object's contents:
//			Assert.assertEquals(arr[1].path, "content.playlist.createRulebasedBtn");
//			
//			Assert.assertObjectEquals(arr[1].attributes, {visible:"false", includeInLayout:"false"});
//		}
		
	}
}