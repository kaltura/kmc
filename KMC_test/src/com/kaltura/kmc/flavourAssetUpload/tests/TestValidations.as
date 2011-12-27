package com.kaltura.kmc.flavourAssetUpload.tests
{
	import com.kaltura.edw.view.window.flavors.AddFlavorAssetsWindow;
	import com.kaltura.edw.vo.UploadFileVo;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import stubs.DummyFileReference;
	
	public class TestValidations extends AddFlavorAssetsWindow
	{		
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
		
		
//		/**
//		 * make sure the same flavour is not selected for more than one file
//		 * ---------------------------------- 
//		 * • more than one file is associated to the same conversion flavor settings.
//		 * • Some of the files are exceeding system upload file size limitation 
//		 * 	(currently set to X GB). please import these files to the system by 
//		 * 	utilizing other ingestion options, applicable in your account (e.g. 
//		 * 	import, drop folder etc)" 
//		 * • Some files required for entry’s readiness for publishing are missing.
//		 * */
//		protected function validate():Boolean;
//			
//			
//			
//			
		[Test][Ignore]
		/**
		 * validation expected to succeed
		 * */
		public function testFileSizeSuccess():void {
			CmsModelLocator.getInstance().extSynModel.partnerData.maxUploadSize = 50;
			
			var filesListAr:Array = new Array();
			var fr:DummyFileReference = new DummyFileReference();
			fr.size = 6000;
			var fvo:UploadFileVo = new UploadFileVo();
			fvo.fileData = fr;
			filesListAr.push(fvo);
			
			fr = new DummyFileReference();
			fr.size = 8030;
			fvo = new UploadFileVo();
			fvo.fileData = fr;
			filesListAr.push(fvo);
			
			fr = new DummyFileReference();
			fr.size = 8658;
			fvo = new UploadFileVo();
			fvo.fileData = fr;
			filesListAr.push(fvo);
			
			filesList = new ArrayCollection(filesListAr);
			
//			if ((file.fileData.size/bytesInMega) > maxSize) {
		}
		
		[Test][Ignore ("test not implemented")]
		/**
		 * validation expected to succeed
		 * */
		public function testFileSizeFail():void {
			CmsModelLocator.getInstance().extSynModel.partnerData.maxUploadSize = 50;
		}
			
		
		[Test]
		/**
		 * validation expected to succeed
		 */
		public function testeMultipleFilesSingleFlavourSuccess():void
		{
			allowAddFiles = true;
			var filesListAr:Array = new Array();
			var fvo:UploadFileVo = new UploadFileVo();
			fvo.flavorParamId = "5";
			filesListAr.push(fvo);
			
			fvo = new UploadFileVo();
			fvo.flavorParamId = "202";
			filesListAr.push(fvo);
			
			fvo = new UploadFileVo();
			fvo.flavorParamId = "201";
			filesListAr.push(fvo);
			
			filesList = new ArrayCollection(filesListAr);
			var result:Boolean = validateMultipleFilesSingleFlavour();
			Assert.assertTrue(result);
		}
		
		[Test]
		/**
		 * validation expected to succeed
		 */
		public function testeMultipleFilesSingleFlavourFail():void
		{
			allowAddFiles = true;
			var filesListAr:Array = new Array();
			var fvo:UploadFileVo = new UploadFileVo();
			fvo.flavorParamId = "5";
			filesListAr.push(fvo);
			
			fvo = new UploadFileVo();
			fvo.flavorParamId = "202";
			filesListAr.push(fvo);
			
			fvo = new UploadFileVo();
			fvo.flavorParamId = "201";
			filesListAr.push(fvo);
			
			fvo = new UploadFileVo();
			fvo.flavorParamId = "5";
			filesListAr.push(fvo);
			
			filesList = new ArrayCollection(filesListAr);
			var result:Boolean = validateMultipleFilesSingleFlavour();
			Assert.assertFalse(result);
		}
	}
}

