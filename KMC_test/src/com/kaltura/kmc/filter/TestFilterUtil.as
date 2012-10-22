package com.kaltura.kmc.filter
{
	import com.kaltura.kmc.modules.content.utils.FilterUtil;
	import com.kaltura.vo.KalturaMetadataSearchItem;
	import com.kaltura.vo.KalturaSearchComparableCondition;
	import com.kaltura.vo.KalturaSearchCondition;
	
	import flexunit.framework.Assert;
	
	public class TestFilterUtil
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
		
		[Test][Ignore]
		public function testCreateFilterFromString():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		/**
		 * make sure profile id is parsed correctly 
		 * 
		 */		
		public function testSaveCustomDataValueProfileId():void
		{
			var ar:Array = [];
			var key:String = "customData:0:profileId=1441";
			var value:String = "1441";
			FilterUtil.saveCustomDataValue(ar, key);
			Assert.assertEquals(ar[0].profileId, 1441);
		}
		
		[Test]
		public function testSaveCustomDataValueField():void
		{
			var ar:Array = [];
			var key:String = "customData:0:field=/*[local-name()='metadata']/*[local-name()='ObjectSubtype']";
			var value:String = "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']";
			FilterUtil.saveCustomDataValue(ar, key);
			Assert.assertEquals(ar[0].field, value);
		}
		
		[Test]
		/**
		 * expected: create a new MetadataSearchItem and return it 
		 * 
		 */		
		public function testGetMetadataProfileSearchItemWhenEmpty():void
		{
			var ar:Array = [];
			var si:KalturaMetadataSearchItem = FilterUtil.getMetadataProfileSearchItem(ar, 1441); 
			Assert.assertObjectEquals(si, ar[0]);
		}
		
		[Test]
		/**
		 * expected: create a new MetadataSearchItem and return it 
		 * (there are values in the array, but not matching values)
		 */		
		public function testGetMetadataProfileSearchItemWhenNotEmpty_Add():void
		{
			var ar:Array = [];
			var si:KalturaMetadataSearchItem = new KalturaMetadataSearchItem();
			si.metadataProfileId = 1551;
			ar.push(si);
			
			si = FilterUtil.getMetadataProfileSearchItem(ar, 1441); 
			Assert.assertObjectEquals(si, ar[1]);
		}
		
		[Test]
		/**
		 * expected: return existing MetadataSearchItem  
		 * (there are values in the array, including a matching value)
		 */		
		public function testGetMetadataProfileSearchItemWhenNotEmpty_Find():void
		{
			var ar:Array = [];
			var si:KalturaMetadataSearchItem = new KalturaMetadataSearchItem();
			si.metadataProfileId = 1441;
			ar.push(si);
			si = new KalturaMetadataSearchItem();
			si.metadataProfileId = 1331;
			ar.push(si);
			
			si = FilterUtil.getMetadataProfileSearchItem(ar, 1441); 
			Assert.assertObjectEquals(si, ar[0]);
		}
		
		
		
		
		[Test]
		/**
		 * expected: 
		 * no fields on the profile yet
		 */		
		public function testgetMetadataFieldSearchCondition_new():void
		{
			var si:KalturaMetadataSearchItem = new KalturaMetadataSearchItem(); // of the profile
			si.metadataProfileId = 1441;
			si.items = [];
			
			var sc:KalturaSearchCondition = FilterUtil.getMetadataFieldSearchCondition(si, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']"); 
			Assert.assertEquals(sc.field, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']");
		}
		
		
		[Test]
		/**
		 * expected: 
		 * fields on the profile, not a matching field
		 */		
		public function testgetMetadataFieldSearchCondition_newWithExisting():void
		{
			var psi:KalturaMetadataSearchItem = new KalturaMetadataSearchItem(); // of the profile
			psi.metadataProfileId = 1441;
			psi.items = [];
			
			var si:KalturaMetadataSearchItem = new KalturaMetadataSearchItem(); // of a field
			si.metadataProfileId = 1441;
			si.items = [];
			var sc:KalturaSearchCondition = new KalturaSearchCondition();
			sc.field = "atar";
			si.items.push(sc);
			
			sc = FilterUtil.getMetadataFieldSearchCondition(psi, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']"); 
			Assert.assertEquals(sc.field, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']");
		}
		
		[Test]
		/**
		 * expected: 
		 * fields on the profile, also a matching field with different value
		 */		
		public function testgetMetadataFieldSearchCondition_existing():void
		{
			var psi:KalturaMetadataSearchItem = new KalturaMetadataSearchItem(); // of the profile
			psi.metadataProfileId = 1441;
			psi.items = [];
			
			var si:KalturaMetadataSearchItem = new KalturaMetadataSearchItem(); // of a field
			si.metadataProfileId = 1441;
			si.items = [];
			var sc:KalturaSearchCondition = new KalturaSearchCondition();
			sc.field = "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']";
			sc.value = "Atar";
			si.items.push(sc);
			
			var sc2:KalturaSearchCondition = FilterUtil.getMetadataFieldSearchCondition(psi, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']"); 
			Assert.assertEquals(sc2.field, "/*[local-name()='metadata']/*[local-name()='ObjectSubtype']");
			Assert.assertFalse(sc2.value == sc.value);
		}
		
		
		
		
	}
}