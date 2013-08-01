package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.storageProfile.StorageProfileList;
	import com.kaltura.core.KClassFactory;
	import com.kaltura.edw.business.ClientUtil;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.FlavorsDataPack;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaStorageProfile;
	import com.kaltura.vo.KalturaStorageProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class ListStorageProfilesCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var lsp:StorageProfileList = new StorageProfileList();
			lsp.addEventListener(KalturaEvent.COMPLETE, result);
			lsp.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(lsp);
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
				// assume what we got are remote storage profiles, even if we got something that inherits (ie, object)
				var objects:Array = (event.data as KalturaStorageProfileListResponse).objects;
				var profiles:Array = new Array();
				var profile:KalturaStorageProfile;
				for each (var obj:Object in objects) {
					if (!(obj is KalturaStorageProfile)) {
						profile = ClientUtil.createClassInstanceFromObject(KalturaStorageProfile, obj);
					}
					else {
						profile = obj as KalturaStorageProfile;
					}
					profiles.push(profile);
				}
				
				(_model.getDataPack(FlavorsDataPack) as FlavorsDataPack).storageProfiles = new ArrayCollection(profiles);
			}	
			_model.decreaseLoadCounter();
		}
	}
}