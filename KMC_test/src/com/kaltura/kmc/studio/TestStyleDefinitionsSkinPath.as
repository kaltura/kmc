package com.kaltura.kmc.studio
{
	import com.kaltura.kmc.modules.studio.view.ApsWizard;
	
	import flexunit.framework.Assert;

	public class TestStyleDefinitionsSkinPath extends ApsWizard
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
		/**
		 * validation expected to succeed.
		 * given (post-dragonfly) dark skinPath, see we get correct paths for both dark and light skins
		 * */
		public function testExtractSkinPathsPostDFDark():void {
			var expectedDark:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/eagle/skin/v3.5.9/skin.swf";
			var expectedLight:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/eagle/skin/v3.5.9/skin_light.swf";
			
			var result:Object = extractSkinPathes(expectedDark);
			Assert.assertEquals(expectedDark, result.dark);
			Assert.assertEquals(expectedLight, result.light);
		}
		
		[Test]
		/**
		 * validation expected to succeed.
		 * given (post-dragonfly) light skinPath, see we get correct paths for both dark and light skins
		 * */
		public function testExtractSkinPathsPostDFLight():void {
			var expectedDark:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/eagle/skin/v3.5.9/skin.swf";
			var expectedLight:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/eagle/skin/v3.5.9/skin_light.swf";
			
			var result:Object = extractSkinPathes(expectedLight);
			Assert.assertEquals(expectedDark, result.dark);
			Assert.assertEquals(expectedLight, result.light);
		}
		
		[Test]
		/**
		 * validation expected to succeed.
		 * given (cassiopeia) dark skinPath, see we get correct paths for both dark and light skins
		 * */
		public function testExtractSkinPathsCassiopeiaDark():void {
			var expectedDark:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/cassiopea/skin.swf?a=2";
			var expectedLight:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/cassiopea/skin_light.swf";
			
			var result:Object = extractSkinPathes(expectedDark);
			Assert.assertEquals(expectedDark, result.dark);
			Assert.assertEquals(expectedLight, result.light);
		}
		
		[Test]
		/**
		 * validation expected to succeed.
		 * given (post-dragonfly) light skinPath, see we get correct paths for both dark and light skins
		 * */
		public function testExtractSkinPathsCassiopeiaLight():void {
			var expectedDark:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/cassiopea/skin.swf?a=2";
			var expectedLight:String = "/content/uiconf/kaltura/kmc/appstudio/kdp3/cassiopea/skin_light.swf?a=2";
			
			var result:Object = extractSkinPathes(expectedLight);
			Assert.assertEquals(expectedDark, result.dark);
			Assert.assertEquals(expectedLight, result.light);
		}
		
		
		// 
	}
}