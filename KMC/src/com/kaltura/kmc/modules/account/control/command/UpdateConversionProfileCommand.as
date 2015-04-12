package com.kaltura.kmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileUpdate;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.control.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class UpdateConversionProfileCommand implements ICommand, IResponder {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		private var _nextEvent:CairngormEvent;


		public function execute(event:CairngormEvent):void {
			_nextEvent = (event as ConversionSettingsEvent).nextEvent;
			
			var cProfile:ConversionProfileVO = event.data as ConversionProfileVO;

			var mr:MultiRequest = new MultiRequest();

			var id:int = cProfile.profile.id;
			var updateProfile:KalturaConversionProfile = cProfile.profile; //prepareForUpdate(profileVo.profile);
			if (updateProfile.flavorParamsIds == null) {
				updateProfile.flavorParamsIds = KalturaClient.NULL_STRING;
			}
			updateProfile.setUpdatedFieldsOnly(true);
			var cpu:ConversionProfileUpdate = new ConversionProfileUpdate(cProfile.profile.id, updateProfile);
			mr.addAction(cpu);

			var cpapu:ConversionProfileAssetParamsUpdate;
			// see if any conversion flavours need to be updated:
			for each (var cpap:KalturaConversionProfileAssetParams in cProfile.flavors) {
				if (cpap.dirty) {
					cpap.setUpdatedFieldsOnly(true);
					cpapu = new ConversionProfileAssetParamsUpdate(id, cpap.assetParamsId, cpap);
					mr.addAction(cpapu);
				}
			}


			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		public function result(event:Object):void {
			_model.loadingFlag = false;

			var er:Object;
			for (var i:int = 0; i < event.data.length; i++) {
				er = event.data[i].error;
				if (er) {
					Alert.show(er.message, ResourceManager.getInstance().getString('account', 'error'));
					break;
				}
			}
			if (!er) {
				Alert.show(ResourceManager.getInstance().getString('account', 'changesSaved'));
			}

			if (_nextEvent) {
				_nextEvent.dispatch();
			}
		}


		public function fault(info:Object):void {
			_model.loadingFlag = false;
			if (info && info.error && info.error.errorMsg) {
				if (info.error.errorMsg.toString().indexOf("Invalid KS") > -1) {
					JSGate.expired();
				} 
				else {
					Alert.show(info && info.error && info.error.errorMsg);
					var getAllProfilesEvent:ConversionSettingsEvent = new ConversionSettingsEvent(ConversionSettingsEvent.LIST_CONVERSION_PROFILES);
					getAllProfilesEvent.dispatch();
				}
			}
		}

	}
}