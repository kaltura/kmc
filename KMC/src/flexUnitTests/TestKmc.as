package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import mx.managers.BrowserManager;
	
	public class TestKmc extends KMC
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
		
//		[Test]
//		public function testGetModuleParent():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
//		
//		
//		[Test]
//		public function testGotoPage():void
//		{
//			gotoPage("dashboard", "");
//			Assert.assertEquals(BrowserManager.getInstance().fragment, "Dashboard");
//		}
		
	}
}