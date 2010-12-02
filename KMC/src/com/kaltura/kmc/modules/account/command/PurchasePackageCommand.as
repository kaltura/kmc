package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.business.PurchasePackageDelegate;
	import com.kaltura.kmc.modules.account.events.ModalWindowEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.model.states.WindowsStates;
	import com.kaltura.kmc.modules.account.vo.PackagesVO;
	import com.kaltura.kmc.modules.account.vo.PaymentDetailsVO;
	
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class PurchasePackageCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			
			var params : Object = _model.context.defaultUrlVars;
			var pdVo : PaymentDetailsVO = _model.paymentDetailsVo;//(event as PackageEvent).data as PaymentDetailsVO; 

			params.package_id = pdVo.packageId;    
			params.customer_first_name = pdVo.customerFirstName;      
			params.customer_last_name = pdVo.customerLastName;      
			params.customer_cc_type = pdVo.customerCcType;      
			params.customer_cc_number = pdVo.customerCcNumber;        
			params.cc_expiration_month = pdVo.ccExpirationMonth;      
			params.cc_expiration_year = pdVo.ccExpirationYear;    
			params.cc_cvv2_number = pdVo.ccCvv2Number;     
			params.customer_address1 = pdVo.customerAddress1;       
			params.customer_address2 = pdVo.customerAddress2;     
			params.customer_city = pdVo.customerCity;    
			params.customer_state = pdVo.customerState;      
			params.customer_zip = pdVo.customerZip;    
			params.customer_country = pdVo.customerCountry;    
			
			var delegate : PurchasePackageDelegate = new PurchasePackageDelegate( this );
			delegate.purchasePackage( params );
			
			_model.gaTrackUrl = "kmc/account/packages/payment/submit/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;	
		}
		
		public function closeAlert( alertRef : Alert ) : void
		{
			PopUpManager.removePopUp( alertRef );
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			
			if( data.result.result.hasOwnProperty('payment_failed') )
			{
				_model.gaTrackUrl = "kmc/account/packages/payment/failed/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;	
				Alert.show( decodeURI( data.result.result.payment_failed.L_LONGMESSAGE0.text() ) );
				return;
			}
			
			_model.gaTrackUrl = "kmc/account/packages/payment/success/package_id/"+_model.paymentDetailsVo.packageId+"/pid/" + _model.context.kc.partnerId + "/uid/" + _model.context.userId;	
			var alert : Alert = Alert.show( data.result.result.payment.ACK.text() );
			setTimeout( closeAlert , 3000 , alert);
			
			var mwEvent : ModalWindowEvent = new ModalWindowEvent( ModalWindowEvent.OPEN_PAYPAL_WINDOW , false , WindowsStates.NONE);
			mwEvent.dispatch();
			
			for( var i:int=0 ; i<_model.listPackages.length ; i++ )
			{
				if((_model.listPackages[i] as PackagesVO).pId == _model.paymentDetailsVo.packageId)
				{
					_model.partnerData.partnerPackage =  uint(_model.paymentDetailsVo.packageId);
					_model.partnerPackage = _model.listPackages[i];	
				}
			} 
		}
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
		}
		
	}
}