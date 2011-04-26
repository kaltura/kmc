package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolder.DropFolderList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class ListDropFolders extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
//			createHandleDummy();
			// ---------------------
			_model.increaseLoadCounter();
//			var filter:KalturaDropFolderFilter = new KalturaDropFolderFilter();
			//TODO filter only media folders
			var listFolders:DropFolderList = new DropFolderList();
			listFolders.addEventListener(KalturaEvent.COMPLETE, result);
			listFolders.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(listFolders); 	
		}
		
		
		override public function result(data:Object):void {
			if (data.error) {
				var er:KalturaError = data.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			else {
				handleDropFolderList(data.data as KalturaDropFolderListResponse);
			}
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * put the folders in an array collection on the model 
		 * */
		protected function handleDropFolderList(lr:KalturaDropFolderListResponse):void {
			var ar:Array = new Array();
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolder) {
					ar.push(o);
				}
			}
			
			_model.dropFolderModel.dropFolders = new ArrayCollection(ar);
		}
		
		protected function createHandleDummy() :void {
			var response:KalturaDropFolderListResponse = new KalturaDropFolderListResponse();
			response.objects = new Array();
			var dff:KalturaDropFolder = new KalturaDropFolder();
			dff.createdAt = 105348965;
			dff.id = 6;
			dff.name = "folder_1";
			response.objects.push(dff);
			
			dff = new KalturaDropFolder();
			dff.createdAt = 1153480065;
			dff.id = 7;
			dff.name = "folder_2";
			dff.slugField = "atar";
			response.objects.push(dff);
			
			dff = new KalturaDropFolder();
			dff.createdAt = 125348565;
			dff.id = 8;
			dff.name = "folder_3";
			response.objects.push(dff);
			
			dff = new KalturaDropFolder();
			dff.createdAt = 135348565;
			dff.id = 9;
			dff.name = "folder_4";
			dff.slugField = "atarsh";
			response.objects.push(dff);
			
			handleDropFolderList(response);
		}
	}
}