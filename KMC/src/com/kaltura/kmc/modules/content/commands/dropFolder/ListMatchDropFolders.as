package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolder.DropFolderList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.types.KalturaDropFolderContentFileHandlerMatchPolicy;
	import com.kaltura.types.KalturaDropFolderFileHandlerType;
	import com.kaltura.types.KalturaDropFolderType;
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderContentFileHandlerConfig;
	import com.kaltura.vo.KalturaDropFolderFilter;
	import com.kaltura.vo.KalturaDropFolderListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
			
	public class ListMatchDropFolders extends KalturaCommand {
				
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaDropFolderFilter = new KalturaDropFolderFilter();
			filter.fileHandlerTypeEqual = KalturaDropFolderFileHandlerType.CONTENT;
			var listFolders:DropFolderList = new DropFolderList(filter);
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
		 * put the folders in an array collection on the model.
		 * only list folders that are configured as MATCH_EXISTING_OR_KEEP_IN_FOLDER. 
		 * */
		protected function handleDropFolderList(lr:KalturaDropFolderListResponse):void {
			var df:KalturaDropFolder;
			var ar:Array = new Array();
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolder) {
					df = o as KalturaDropFolder;
					var cfg:KalturaDropFolderContentFileHandlerConfig = df.fileHandlerConfig as KalturaDropFolderContentFileHandlerConfig; 
					if (cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.MATCH_EXISTING_OR_KEEP_IN_FOLDER) {
						ar.push(df);
					}
				}
			}
			
			_model.dropFolderModel.dropFolders = new ArrayCollection(ar);
		}
	}
}