package com.kaltura.kmc.business
{
	import org.flexunit.Assert;

	public class extendPermissionManager extends PermissionManager
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
	}
}