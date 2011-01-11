package com.kaltura.kmc.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	
	import mx.rpc.IResponder;
	
	public class AddNewExternalSyndicationCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			event.target;
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			
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
		}
		

	}
}