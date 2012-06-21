package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.events.AccessControlEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.AccessControlProfileVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class UpdateAccessControlProfileCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			var accessControl:AccessControlProfileVO = event.data;
			accessControl.profile.setUpdatedFieldsOnly(true);
			var updateAccessControl:AccessControlUpdate = new AccessControlUpdate(accessControl.profile.id, accessControl.profile);
			updateAccessControl.addEventListener(KalturaEvent.COMPLETE, result);
			updateAccessControl.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updateAccessControl);
		}


		public function result(data:Object):void {
			_model.loadingFlag = false;
			if (data.success) {
				Alert.show(ResourceManager.getInstance().getString('account', 'updateAccessControl'));
				var getAllProfilesEvent:AccessControlEvent = new AccessControlEvent(AccessControlEvent.ACCOUNT_LIST_ACCESS_CONTROLS_PROFILES);
				getAllProfilesEvent.dispatch();
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('account', 'error'));
			}
		}


		public function fault(info:Object):void {
			var e:KalturaEvent = info as KalturaEvent;
			if (e && e.error) {
				if (e.error.errorMsg && e.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
					JSGate.expired();
					return;
				}
				else if (e.error.errorCode == "ACCESS_CONTROL_NEW_VERSION_UPDATE") {
					Alert.show(ResourceManager.getInstance().getString('account', 'noUpdateNewAccessControl'));
				}
				else {
					Alert.show(ResourceManager.getInstance().getString('account', 'noUpdateAccessControl'));
				}
			}
			Alert.show(ResourceManager.getInstance().getString('account', 'noUpdateAccessControl'));
			_model.loadingFlag = false;
		}


	}
}
