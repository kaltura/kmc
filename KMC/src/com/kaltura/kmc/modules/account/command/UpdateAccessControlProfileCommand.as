package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.events.AccessControlProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.AccessControlProfileVO;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class UpdateAccessControlProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var accessControl:AccessControlProfileVO = event.data;
			accessControl.profile.setUpdatedFieldsOnly(true);
			var updateAccessControl:AccessControlUpdate = new AccessControlUpdate(accessControl.profile.id, accessControl.profile);
		 	updateAccessControl.addEventListener(KalturaEvent.COMPLETE, result);
			updateAccessControl.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updateAccessControl);	
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			if(data.success)
			{
				Alert.show(ResourceManager.getInstance().getString('account', 'updateAccessControl'));
				var getAllProfilesEvent:AccessControlProfileEvent = new AccessControlProfileEvent(AccessControlProfileEvent.ACCOUNT_LIST_ACCESS_CONTROLS_PROFILES);
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
			Alert.show(ResourceManager.getInstance().getString('account', 'noUpdateAccessControl'));
		}
		

	}
}