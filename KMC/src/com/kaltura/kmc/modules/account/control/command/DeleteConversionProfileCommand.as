package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.control.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class DeleteConversionProfileCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();

		private var _profs:Array;

		public function execute(event:CairngormEvent):void {
			_profs = event.data;
			var rm:IResourceManager = ResourceManager.getInstance();
			
			if (_profs.length == 0) {
				Alert.show(rm.getString('account', 'noProfilesSelected'));
			}
			else {
				var delStr:String = "";
				for each (var cp:ConversionProfileVO in _profs) {
					if (!cp.profile.isDefault) {
						delStr += '\n' + cp.profile.name;
					}
				}
				
				var msg:String = rm.getString('account', 'deleteAlertMsg') + delStr + " ?";
				var title:String = rm.getString('account', 'deleteAlertTitle');
				
				Alert.show(msg, title, Alert.YES | Alert.NO, null, deleteProfiles);
			}
		}
		
		
		private function deleteProfiles(evt:CloseEvent):void {
			if (evt.detail == Alert.YES) {
				
				var mr:MultiRequest = new MultiRequest();
				for each (var cp:ConversionProfileVO in _profs) {
					var deleteConversions:ConversionProfileDelete = new ConversionProfileDelete(cp.profile.id);
					mr.addAction(deleteConversions);
				}
				
				
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
		}

		public function result(data:Object):void {
			_model.loadingFlag = false;
			if (data.success) {
				Alert.show(ResourceManager.getInstance().getString('account', 'deleteConvProfilesDoneMsg'));
				var getAllProfilesEvent:ConversionSettingsEvent = new ConversionSettingsEvent(ConversionSettingsEvent.LIST_CONVERSION_PROFILES);
				getAllProfilesEvent.dispatch();
			}
			else {
				Alert.show(data.error, ResourceManager.getInstance().getString('account', 'error'));
			}

		}


		public function fault(info:Object):void {
			if (info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}


	}
}
