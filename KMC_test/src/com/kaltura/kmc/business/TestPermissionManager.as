package com.kaltura.kmc.business
{
	import com.kaltura.kmc.business.PermissionManager;
	
	import flexunit.framework.Assert;
	
	public class TestPermissionManager
	{		
		private var pm:PermissionManager = PermissionManager.getInstance();
		
		[Before]
		public function setUp():void
		{
			pm.init(TestPermissionParser.test1);
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
		public function testInit():void
		{
			//test general creation of VOs
			var arr:Array = pm.instructionVos;
			Assert.assertEquals(arr.length , 8 );
			//test permissions
			arr = pm.permissions;
			Assert.assertEquals(arr.length , 10 );
			//test hideTabs
			arr = pm.hideTabs;
			Assert.assertEquals(arr.length , 3 );

		}
	}
}