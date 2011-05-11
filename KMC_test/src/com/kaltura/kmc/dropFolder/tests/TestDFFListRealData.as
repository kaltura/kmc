package com.kaltura.kmc.dropFolder.tests
{
	import com.kaltura.kmc.modules.content.commands.dropFolder.ListDropFoldersFilesCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.vo.KalturaDropFolderFile;
	import com.kaltura.vo.KalturaDropFolderFileListResponse;
	import com.kaltura.vo.KalturaMediaEntry;
	
	import flexunit.framework.Assert;
	
	import mx.resources.ResourceManager;

	public class TestDFFListRealData extends ListDropFoldersFilesCommand
	{		
		
		[ResourceBundle("cms")]
		
			/**
			 * create a dummy list reponse 
			 */
			protected function createDummy():KalturaDropFolderFileListResponse {
				var response:KalturaDropFolderFileListResponse = new KalturaDropFolderFileListResponse();
				response.objects = new Array();
				
				var dff:KalturaDropFolderFile = new KalturaDropFolderFile();
				dff.id = 45;
				dff.partnerId = 346151;
				dff.dropFolderId = 1;
				dff.fileName = "Pinky_HD.flv";
				dff.fileSize = 488160;
				dff.fileSizeLastSetAt = 1305122832;
				dff.status = 3;
				dff.parsedSlug = "Pinky";
				dff.parsedFlavor = "HD";
				dff.createdAt = 1305120068;
				dff.updatedAt = 1305122832;
				response.objects.push(dff);
				
				dff = new KalturaDropFolderFile();
				dff.id = 46;
				dff.partnerId = 346151;
				dff.dropFolderId = 1;
				dff.fileName = "Pinky_Source.flv";
				dff.fileSize = 488160;
				dff.fileSizeLastSetAt = 1305120454;
				dff.status = 9;
				dff.parsedSlug = "Pinky";
				dff.parsedFlavor = "Source";
				dff.errorCode = 1;
				dff.errorDescription = "Internal error updating entry";
				dff.createdAt = 1305120068;
				dff.updatedAt = 1305120454;
				response.objects.push(dff);
				
				
				dff = new KalturaDropFolderFile();
				dff.id = 43;
				dff.partnerId = 346151;
				dff.dropFolderId = 1;
				dff.fileName = "Limeee_HD.flv";
				dff.fileSize = 483691;
				dff.fileSizeLastSetAt = 1305122833;
				dff.status = 8;
				dff.parsedSlug = "Limeee";
				dff.parsedFlavor = "HD";
				dff.errorDescription = "No matching entry found";
				dff.createdAt = 1305119763;
				dff.updatedAt = 1305122833;
				response.objects.push(dff);
				
				dff = new KalturaDropFolderFile();
				dff.id = 44;
				dff.partnerId = 346151;
				dff.dropFolderId = 1;
				dff.fileName = "Limeee_Source.flv";
				dff.fileSize = 483691;
				dff.fileSizeLastSetAt = 1305122833;
				dff.status = 8;
				dff.parsedSlug = "Limeee";
				dff.parsedFlavor = "Source";
				dff.errorDescription = "No matching entry found";
				dff.createdAt = 1305119763;
				dff.updatedAt = 1305122833;
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
				_entry = new KalturaMediaEntry();
				_entry.referenceId = 'Pinky';
				_eventType = DropFolderFileEvent.LIST_BY_SELECTED_FOLDER_HIERCH;
				var response:KalturaDropFolderFileListResponse = createDummy();
				var list:Array = handleDropFolderFileList(response);
				var defaultName:String = ResourceManager.getInstance().getString('cms', 'parseFailed');
				
				Assert.assertObjectEquals(response.objects[0], list[0].files[0]);
				Assert.assertEquals(1, list[0].files.length);
				Assert.assertEquals('Pinky', list[0].parsedSlug);
				Assert.assertEquals(1305120068, list[0].createdAt);
				
				Assert.assertObjectEquals(response.objects[2], list[1].files[0]);
				Assert.assertObjectEquals(response.objects[3], list[1].files[1]);
				Assert.assertEquals(2, list[1].files.length);
				Assert.assertEquals('Limeee', list[1].parsedSlug);
				Assert.assertEquals(1305119763, list[1].createdAt);
				
				Assert.assertObjectEquals(response.objects[1], list[2].files[0]);
				Assert.assertEquals(1, list[2].files.length);
				Assert.assertEquals(defaultName, list[2].parsedSlug);
				Assert.assertEquals(1305120068, list[2].createdAt);
				
				Assert.assertEquals(3, list.length);
			}
		
		
	}
}