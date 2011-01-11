package com.kaltura.kmc.modules.account.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.account.events.ContactEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ContactSalesForceCommand implements ICommand {
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var e:ContactEvent = event as ContactEvent;
			var params:Object = _model.context.defaultUrlVars;
			params.name = e.userName;
			params.phone = e.userPhone;
			params.comments = e.userComment;
			params.services = e.services;

//			http://www.kaltura.com/index.php/partnerservices2/contactsalesforce
			var srv:HTTPService = new HTTPService();
			srv.url = _model.context.rootUrl + '/index.php/partnerservices2/contactsalesforce';
			srv.method = "POST";
			srv.resultFormat = "e4x";
			srv.showBusyCursor = true;
			srv.addEventListener(ResultEvent.RESULT, result);
			srv.addEventListener(FaultEvent.FAULT, fault);
			srv.send(params);
		}


		/**
		 * handles success and "pseudo" errors, 
		 * like when the server returns data but it holds error.
		 * @param event
		 */		
		private function result(event:ResultEvent):void {
			var xml:XML = new XML(event.result);
			// if the server returned an error as an answer
			if (xml.error && xml.error.num_0) {
				if (xml.error.num_0.code.toString() == APIErrorCode.INVALID_KS) {
					JSGate.expired();
					return;
				}
				Alert.show(xml.error.num_0.desc, ResourceManager.getInstance().getString('account', 'error'));
			}
			// if call succeeded
			else {
				var alert:Alert = Alert.show(ResourceManager.getInstance().getString('account', 'thankYou'));
			}
			_model.loadingFlag = false; 
		}


		/**
		 * handle "real" errors, like ioerrors, etc 
		 * @param event
		 */		
		private function fault(event:FaultEvent):void {
			Alert.show(event.fault.faultString, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}
	}
}