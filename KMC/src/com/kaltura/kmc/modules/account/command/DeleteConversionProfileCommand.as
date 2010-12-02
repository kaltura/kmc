package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class DeleteConversionProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var mr:MultiRequest = new MultiRequest();
			for each (var id:int in event.data)
			{
				var deleteConversions:ConversionProfileDelete = new ConversionProfileDelete(id);
				mr.addAction(deleteConversions);
			}
			
		//	var deleteAccessControlsT:AccessControlDelete = new AccessControlDelete(32);
		//	mr.addAction(deleteAccessControlsT);
			
            mr.addEventListener(KalturaEvent.COMPLETE, result);
            mr.addEventListener(KalturaEvent.FAILED, fault);
            _model.context.kc.post(mr); 
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			if(data.success)
			{
				Alert.show(ResourceManager.getInstance().getString('account', 'deleteConvProfilesDoneMsg'));
				var getAllProfilesEvent:ConversionSettingsEvent = new ConversionSettingsEvent(ConversionSettingsEvent.LIST_CONVERSION_PROFILES);
				getAllProfilesEvent.dispatch();
			}
			else
			{
				Alert.show(data.error, ResourceManager.getInstance().getString('account', 'error'));
			}

			_model.partnerInfoLoaded = true;
		}
		
		public function fault(info:Object):void
		{			
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}
		

	}
}