package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class AddNewConversionProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var profileVo:ConversionProfileVO = event.data as ConversionProfileVO;
			var addConversionProfile:ConversionProfileAdd = new ConversionProfileAdd(profileVo.profile);
			addConversionProfile.addEventListener(KalturaEvent.COMPLETE, result);
			addConversionProfile.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addConversionProfile);
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			var getAllProfilesEvent:ConversionSettingsEvent = new ConversionSettingsEvent(ConversionSettingsEvent.LIST_CONVERSION_PROFILES);
			getAllProfilesEvent.dispatch();
		}
		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}
		

	}
}