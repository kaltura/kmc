package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.storageProfile.StorageProfileList;
	import com.kaltura.edw.business.ClientUtil;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.types.KalturaStorageProfileStatus;
	import com.kaltura.vo.KalturaFilter;
	import com.kaltura.vo.KalturaStorageProfile;
	import com.kaltura.vo.KalturaStorageProfileFilter;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListStorageProfilesCommand implements ICommand, IResponder {
		
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var f:KalturaStorageProfileFilter = new KalturaStorageProfileFilter();
			f.statusIn = KalturaStorageProfileStatus.AUTOMATIC + "," + KalturaStorageProfileStatus.MANUAL;
			var list:StorageProfileList = new StorageProfileList(f);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(list);
		}
		
		public function result(event:Object):void {
			_model.loadingFlag = false;
			var temp:Array = new Array();
			// add the "none" object
			var rs:KalturaStorageProfile = new KalturaStorageProfile();
			rs.id = KalturaClient.NULL_INT; // same as "delete value" of the client
			rs.name = ResourceManager.getInstance().getString('account', 'n_a');
			temp.push(rs);
			// add the rest of the storages
			for each (var o:Object in event.data.objects) {
				if (!(o is KalturaStorageProfile)) {
					o = ClientUtil.createClassInstanceFromObject(KalturaStorageProfile, o);
				}
				temp.push(o);
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