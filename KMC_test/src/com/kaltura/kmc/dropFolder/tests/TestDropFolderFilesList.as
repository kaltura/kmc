package com.kaltura.kmc.dropFolder.tests
{
	import com.kaltura.kmc.modules.content.commands.dropFolder.ListDropFoldersFilesCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.types.KalturaDropFolderFileStatus;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	
	import flexunit.framework.Assert;
	
	import mx.resources.ResourceManager;
	
	public class TestDropFolderFilesList extends ListDropFoldersFilesCommand
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
		
		/**
		 * create a dummy list reponse where some files have no parsed slug 
		 */
		protected function createDummy2():KalturaDropFolderFileListResponse {
			var response:KalturaDropFolderFileListResponse = new KalturaDropFolderFileListResponse();
			response.objects = new Array();
			var dff:KalturaDropFolderFile = new KalturaDropFolderFile();
			dff.createdAt = 105348965;
			dff.dropFolderId = 6;
			dff.fileName = "file_1";
			dff.fileSize = 3145728.1111111111111111111111111;
			dff.status = KalturaDropFolderFileStatus.NO_MATCH; 
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			
			dff = new KalturaDropFolderFile();
			dff.createdAt = 115348665;
			dff.dropFolderId = 6;
			dff.fileName = "file_2";
			dff.fileSize = 3145728*2;
			dff.status = KalturaDropFolderFileStatus.NO_MATCH;
			dff.parsedSlug = "";
			response.objects.push(dff);
			
			dff = new KalturaDropFolderFile();
			dff.createdAt = 125348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_3";
			dff.fileSize = 3145728*6;
			dff.status = KalturaDropFolderFileStatus.NO_MATCH;
			dff.parsedSlug = "";
			response.objects.push(dff);
			dff = new KalturaDropFolderFile();
			dff.createdAt = 135348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_4";
			dff.fileSize = 3145728/4;
			dff.status = KalturaDropFolderFileStatus.NO_MATCH;
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			
			return response;
		}
		
		/**
		 * create a dummy list reponse 
		 */
		protected function createDummy():KalturaDropFolderFileListResponse {
			var response:KalturaDropFolderFileListResponse = new KalturaDropFolderFileListResponse();
			response.objects = new Array();
			
			var dff:KalturaDropFolderFile = new KalturaDropFolderFile();
			dff.createdAt = 105348965;
			dff.dropFolderId = 6;
			dff.fileName = "file_1";
			dff.fileSize = 3145728.1111111111111111111111111;
			dff.status = KalturaDropFolderFileStatus.PENDING; 
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			
			dff = new KalturaDropFolderFile();
			dff.createdAt = 115348665;
			dff.dropFolderId = 6;
			dff.fileName = "file_2";
			dff.fileSize = 3145728*2;
			dff.status = KalturaDropFolderFileStatus.PENDING;
			dff.parsedSlug = "atar";
			response.objects.push(dff);
			
			
			dff = new KalturaDropFolderFile();
			dff.createdAt = 125348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_3";
			dff.fileSize = 3145728*6;
			dff.status = KalturaDropFolderFileStatus.PENDING;
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);
			
			dff = new KalturaDropFolderFile();
			dff.createdAt = 135348565;
			dff.dropFolderId = 6;
			dff.fileName = "file_4";
			dff.fileSize = 3145728/4;
			dff.status = KalturaDropFolderFileStatus.PENDING;
			dff.parsedSlug = "atarsh";
			response.objects.push(dff);
			
			return response;
		}
		
		[Test]
		/**
		 * expected to create the files list grouped by parsedSlug, 
		 * where files with no parsedSlug should go under one group
		 */
		public function testSlugResponseNoParsed():void
		{
			_eventType = DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH;
			var response:KalturaDropFolderFileListResponse = createDummy2();
			var list:Array = handleDropFolderFileList(response);
			var defaultName:String = '';//ResourceManager.getInstance().getString('cms', 'parseFailed');
			
			// this if is because we don't know the objects' order in the list.
			if (list[1].parsedSlug == "atar") {
				Assert.assertObjectEquals(response.objects[0], list[1].files[0]);
				Assert.assertObjectEquals(response.objects[1], list[1].files[1]);
				Assert.assertEquals("atar", list[1].parsedSlug);
				Assert.assertEquals(105348965, list[1].createdAt);
				
				Assert.assertObjectEquals(response.objects[2], list[0].files[0]);
				Assert.assertObjectEquals(response.objects[3], list[0].files[1]);
				Assert.assertEquals(defaultName, list[0].parsedSlug);
				Assert.assertEquals(115348665, list[0].createdAt);
			}
			else {
				Assert.assertObjectEquals(response.objects[0], list[0].files[0]);
				Assert.assertObjectEquals(response.objects[1], list[0].files[1]);
				Assert.assertEquals("atar", list[0].parsedSlug);
				Assert.assertEquals(105348965, list[0].createdAt);
				
				Assert.assertObjectEquals(response.objects[2], list[1].files[0]);
				Assert.assertObjectEquals(response.objects[3], list[1].files[1]);
				Assert.assertEquals(defaultName, list[1].parsedSlug);
				Assert.assertEquals(115348665, list[1].createdAt);
				
			}
			
			Assert.assertEquals(2, list.length);
		}
		
		
		[Test]
		/**
		 * expected to create the files list grouped by parsedSlug
		 */
		public function testHandleSlugResponse():void
		{
			_eventType = DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH;
			var response:KalturaDropFolderFileListResponse = createDummy();
			var list:Array = handleDropFolderFileList(response);
			
			// this if is because we don't know the objects' order in the list.
			if (list[1].parsedSlug == "atar") {
				Assert.assertObjectEquals(response.objects[0], list[1].files[0]);
				Assert.assertObjectEquals(response.objects[1], list[1].files[1]);
				Assert.assertEquals("atar", list[1].parsedSlug);
				Assert.assertEquals(105348965, list[1].createdAt);
				
				Assert.assertObjectEquals(response.objects[2], list[0].files[0]);
				Assert.assertObjectEquals(response.objects[3], list[0].files[1]);
				Assert.assertEquals("atarsh", list[0].parsedSlug);
				Assert.assertEquals(125348565, list[0].createdAt);
			}
			else {
				Assert.assertObjectEquals(response.objects[0], list[0].files[0]);
				Assert.assertObjectEquals(response.objects[1], list[0].files[1]);
				Assert.assertEquals("atar", list[0].parsedSlug);
				Assert.assertEquals(105348965, list[0].createdAt);
				
				Assert.assertObjectEquals(response.objects[2], list[1].files[0]);
				Assert.assertObjectEquals(response.objects[3], list[1].files[1]);
				Assert.assertEquals("atarsh", list[1].parsedSlug);
				Assert.assertEquals(125348565, list[1].createdAt);
				
			}
			
			Assert.assertEquals(2, list.length);
		}
		
		
		[Test]
		/**
		 * expected to create the files list in a flat structure 
		 */
		public function testHandleSimpleResponse():void
		{
			_eventType = DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_FLAT;
			var response:KalturaDropFolderFileListResponse = createDummy();
			var list:Array = handleDropFolderFileList(response) ;
			
			for (var i:int = 0; i<response.objects.length; i++) {
				Assert.assertObjectEquals(list[i], response.objects[i]);
			}
		}
		
	}
}