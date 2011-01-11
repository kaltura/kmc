package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.accessControl.AccessControlDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.events.AccessControlProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class DeleteAccessControlProfilesCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		private var multiProfiles:Boolean = false;
		public function execute(event:CairngormEvent):void
		{
			var mr:MultiRequest = new MultiRequest();
			multiProfiles = (event.data.length > 1);
			for each (var id:int in event.data)
			{
				var deleteAccessControls:AccessControlDelete = new AccessControlDelete(id);
				mr.addAction(deleteAccessControls);
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
				if(multiProfiles)
				{
					Alert.show(ResourceManager.getInstance().getString('account', 'deleteAccessProfilesDoneMsg'));
				}
				else
				{
					Alert.show(ResourceManager.getInstance().getString('account', 'deleteAccessProfileDoneMsg'));
				}
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
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}
		

	}
}