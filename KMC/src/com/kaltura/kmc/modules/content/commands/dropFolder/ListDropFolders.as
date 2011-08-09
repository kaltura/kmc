package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.dropFolder.DropFolderList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderEvent;
	import com.kaltura.types.KalturaDropFolderContentFileHandlerMatchPolicy;
	import com.kaltura.types.KalturaDropFolderFileHandlerType;
	import com.kaltura.types.KalturaDropFolderOrderBy;
	import com.kaltura.types.KalturaDropFolderStatus;
	import com.kaltura.types.KalturaDropFolderType;
	import com.kaltura.vo.KalturaDropFolder;
	import com.kaltura.vo.KalturaDropFolderContentFileHandlerConfig;
	import com.kaltura.vo.KalturaDropFolderFilter;
	import com.kaltura.vo.KalturaDropFolderListResponse;
	import com.kaltura.vo.KalturaFtpDropFolder;
	import com.kaltura.vo.KalturaRemoteDropFolder;
	import com.kaltura.vo.KalturaScpDropFolder;
	import com.kaltura.vo.KalturaSftpDropFolder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class ListDropFolders extends KalturaCommand {
		
		private var _flags:uint;
		
		override public function execute(event:CairngormEvent):void {
			_flags = (event as DropFolderEvent).flags;
			_model.increaseLoadCounter();
			var filter:KalturaDropFolderFilter = new KalturaDropFolderFilter();
//			filter.fileHandlerTypeEqual = KalturaDropFolderFileHandlerType.CONTENT;
			filter.orderBy = KalturaDropFolderOrderBy.NAME_DESC;
			filter.statusEqual = KalturaDropFolderStatus.ENABLED;
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
		 * put the folders in an array collection on the model 
		 * */
		protected function handleDropFolderList(lr:KalturaDropFolderListResponse):void {
			// so that the classes will be comiled in
			var dummy1:KalturaScpDropFolder;
			var dummy2:KalturaSftpDropFolder;
			var dummy3:KalturaFtpDropFolder;
			
			var df:KalturaDropFolder;
			var ar:Array = new Array();
			for each (var o:Object in lr.objects) {
				if (o is KalturaDropFolder ) {
					df = o as KalturaDropFolder;
					if (df.fileHandlerType == KalturaDropFolderFileHandlerType.CONTENT) {
						var cfg:KalturaDropFolderContentFileHandlerConfig = df.fileHandlerConfig as KalturaDropFolderContentFileHandlerConfig;
						if (_flags & DropFolderEvent.ADD_NEW && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.ADD_AS_NEW) {
							ar.push(df);
						}
						else if (_flags & DropFolderEvent.MATCH_OR_KEEP && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.MATCH_EXISTING_OR_KEEP_IN_FOLDER) {
							ar.push(df);
						} 
						else if (_flags & DropFolderEvent.MATCH_OR_NEW && cfg.contentMatchPolicy == KalturaDropFolderContentFileHandlerMatchPolicy.MATCH_EXISTING_OR_ADD_AS_NEW) {
							ar.push(df);
						} 
					}
					else if (_flags & DropFolderEvent.XML_FOLDER && df.fileHandlerType == KalturaDropFolderFileHandlerType.XML){
						ar.push(df);
					}
				}
			}
			
			_model.dropFolderModel.dropFolders = new ArrayCollection(ar);
		}
		
	}
}