package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.adminUser.AdminUserUpdatePassword;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.vo.KalturaAdminUser;
	
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class UpdateAdminPasswordCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
		   /*  var params : Object = _model.context.defaultUrlVars;
			params.adminKuser_email = _model.adminData.oldEmail;
			params.new_email = _model.adminData.newEmail;
			params.adminKuser_password = _model.adminData.oldPassword;	 
			params.new_password = _model.adminData.newPassword; */
			var oldEmail:String = _model.adminData.oldEmail;
			var newEmail:String = _model.adminData.newEmail;
			var oldPassword:String = _model.adminData.oldPassword;	 
			var newPassword:String= _model.adminData.newPassword;  
		 	
			/* var delegate : UpdateAdminPasswordDelegate = new UpdateAdminPasswordDelegate( this );
			delegate.updateAdminPassword( params );   */
			var updateAdminPsw:AdminUserUpdatePassword = new AdminUserUpdatePassword(oldEmail, oldPassword, newEmail, newPassword);
			updateAdminPsw.addEventListener(KalturaEvent.COMPLETE, result);
			updateAdminPsw.addEventListener(KalturaEvent.FAILED, fault);
			//TODO make only this call secured
//			_model.context.kc.protocol = "https://";
			_model.context.kc.post(updateAdminPsw); 
//			_model.context.kc.protocol = "http://";
		}
		
		public function closeAlert( alertRef : Alert ) : void
		{
			PopUpManager.removePopUp( alertRef );
		}
		
		public function result(data:Object):void
		{
			KalturaAdminUser(data.data);
			_model.loadingFlag = false;
			_model.adminData.oldEmail = _model.adminData.newEmail;
						
			if(_model.saveAndExitFlag)
			{
				ExternalInterface.call("onTabChange");
				return;
			}
			
			var alert : Alert =  Alert.show( ResourceManager.getInstance().getString('account', 'changesSaved'));
			setTimeout( closeAlert , 3000 , alert);
		}
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			// show readable error message
			//TODO if one day we get an enum of error codes from server, show locale string instead.
			var alert : Alert = Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error')); 
//			setTimeout( closeAlert , 2000 , alert);
		}
	}
}