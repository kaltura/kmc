package flexUnitTests
{
	import org.flexunit.Assert;
	

	public class TestKmc extends KMC
	{	
		
		[Test]
		public function testRemoveExistingModule():void {
			var kmcuiconf:XML = <root>
					<!-- path to skin file -->
					<skinPath>http://localhost/kmc/KMC/bin-debug/workspaces/kmc/KMC/assets/kmc_skin.swf</skinPath>
					<!-- path to help page -->
					<helpPage>index.php/kmc/kmc2help</helpPage>
					<modules>
				        <module id="content" uiconf="1002420" path="Content.swf" />
				 		<module id="studio" uiconf="1002416" path="Studio.swf"/>
						<module id="dashboard" uiconf="1002412" path="Dashboard.swf"/>
						<module id="analytics" uiconf="1002413" path="Analytics.swf"/>
				        <module id="account" uiconf="1002414" path="Account.swf"/>
					</modules>					
				</root>;
			removeModule(kmcuiconf, "content");
			if (kmcuiconf.modules.module.(@id == "content").length() > 0) {
				Assert.fail("module not removed");
			}
		}
		
		[Test]
		public function testRemoveNonExistingModule():void {
			var kmcuiconf:XML = <root>
					<!-- path to skin file -->
					<skinPath>http://localhost/kmc/KMC/bin-debug/workspaces/kmc/KMC/assets/kmc_skin.swf</skinPath>
					<!-- path to help page -->
					<helpPage>index.php/kmc/kmc2help</helpPage>
					<modules>
				        <module id="content" uiconf="1002420" path="Content.swf" />
				 		<module id="studio" uiconf="1002416" path="Studio.swf"/>
						<module id="dashboard" uiconf="1002412" path="Dashboard.swf"/>
						<module id="analytics" uiconf="1002413" path="Analytics.swf"/>
				        <module id="account" uiconf="1002414" path="Account.swf"/>
					</modules>					
				</root>;
			try {
				removeModule(kmcuiconf, "atar");
			} catch (e:Error) {
				Assert.fail("method crashed");
			}
			
		}
		
		
		
		
//		[Before]
//		public function setUp():void
//		{
//		}
//		
//		[After]
//		public function tearDown():void
//		{
//		}
//		
//		[BeforeClass]
//		public static function setUpBeforeClass():void
//		{
//		}
//		
//		[AfterClass]
//		public static function tearDownAfterClass():void
//		{
//		}
		
		
	}
}