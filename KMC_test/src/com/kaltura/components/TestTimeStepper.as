package com.kaltura.components
{
	import com.kaltura.controls.TimeStepper;
	
	import org.flexunit.Assert;
	
	public class TestTimeStepper
	{		
		
		private var ts:TimeStepper;
		
		[Before]
		public function setUp():void
		{
			ts = new TimeStepper();
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
		public function testGetTimeAsObjectHours():void
		{
			// 28/8/12, 20:47:28 GMT+3
			var o:Object = ts.getTimeAsObject(1346176048);
			Assert.assertEquals(17, o.hour);
		}
		
		[Test]
		public function testGetTimeAsObjectMinutes():void
		{
			// 28/8/12, 20:47:28 GMT+3
			var o:Object = ts.getTimeAsObject(1346176048);
			Assert.assertEquals(47, o.minute);
		}
		
		[Test]
		public function testGetTimeAsObjectSeconds():void
		{
			// 28/8/12, 20:47:28 GMT+3
			var o:Object = ts.getTimeAsObject(1346176048);
			Assert.assertEquals(28, o.second);
		}
	}
}