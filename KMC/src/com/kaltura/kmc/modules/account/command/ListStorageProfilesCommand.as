package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.storageProfile.StorageProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.KalturaStorageProfile;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;

	public class ListStorageProfilesCommand implements ICommand, IResponder {
		
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var list:StorageProfileList = new StorageProfileList();
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(list);
		}
		
		public function result(event:Object):void {
			_model.loadingFlag = false;
			var temp:Array = new Array();
			// add the "none" object
			var rs:KalturaStorageProfile = new KalturaStorageProfile();
			rs.id = int.MIN_VALUE; // same as the default
			rs.name = "N/A";
			temp.push(rs);
			// add the rest of the storages
			for each (var o:Object in event.data.objects) {
				if (o is KalturaStorageProfile) {
					temp.push(o);
				}
			} 
			
			_model.storageProfiles = new ArrayCollection(temp);
		}
		
		public function fault(event:Object):void {
			_model.loadingFlag = false;
			if(event && event.error && event.error.errorMsg) {
				if(event.error.errorMsg.toString().indexOf("Invalid KS") > -1 ) {
					JSGate.expired();
				} else {
					Alert.show(event && event.error && event.error.errorMsg);
				}
			}
		}
	}
}