package com.kaltura.kmc.business
{
	import org.flexunit.Assert;

	public class testHelpist
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
			var map:XML =<Help> 
							<Item key="a" anchor="1" />
							<Item key="b" anchor="2" />
							<Item key="c" anchor="3" />
						</Help>;
			var mp:XMLList = map.Item;
			Helpist.init(mp, "/baseUrl/", "www.kaltura.com", "http://");
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testGetAnchore():void {
			var res:String = Helpist.getMapping("a");
			Assert.assertEquals("1", res);
		}
	}
}