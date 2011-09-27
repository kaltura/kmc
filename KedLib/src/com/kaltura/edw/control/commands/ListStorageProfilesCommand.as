package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.storageProfile.StorageProfileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaStorageProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class ListStorageProfilesCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var lsp:StorageProfileList = new StorageProfileList();
			lsp.addEventListener(KalturaEvent.COMPLETE, result);
			lsp.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(lsp);
		}
		
		
		override public function result(event:Object):void {
			// error handling
			var er:KalturaError ;
			if (event.error) {
				er = event.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, "Error");
				}
			}
			
			// result
			else {
				_model.entryDetailsModel.storageProfiles = new ArrayCollection((event.data as KalturaStorageProfileListResponse).objects);
			}	
			_model.decreaseLoadCounter();
		}
	}
}