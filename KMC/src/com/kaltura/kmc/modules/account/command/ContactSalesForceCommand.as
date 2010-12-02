package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.business.ContactSalesForceDelegate;
	import com.kaltura.kmc.modules.account.events.ContactEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ContactSalesForceCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			var e : ContactEvent = event as ContactEvent;
			var params : Object = _model.context.defaultUrlVars;
			params.name = e.userName;
			params.phone = e.userPhone;
			params.comments = e.userComment;
			params.services = e.services;
			
			//TODO: convert this command to V.3
			var delegate : ContactSalesForceDelegate  = new ContactSalesForceDelegate( this );
			delegate.contactSalesForce( params );
		}
		
		public function closeAlert( alertRef : Alert ) : void
		{
			PopUpManager.removePopUp( alertRef );
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			var alert : Alert = Alert.show( ResourceManager.getInstance().getString('account', 'thankYou') );
			setTimeout( closeAlert , 3000 , alert);
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