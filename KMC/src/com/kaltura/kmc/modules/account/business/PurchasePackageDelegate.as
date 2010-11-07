package com.kaltura.kmc.modules.account.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import flash.external.ExternalInterface;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class PurchasePackageDelegate implements IResponder
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function PurchasePackageDelegate( responder : IResponder )
		{
			this.responder = responder;
			this.service = ServiceLocator.getInstance().getHTTPService( 'purchasePackageSrv' );
		}
		
		public function purchasePackage( params : Object ):void
		{
			var token : AsyncToken = service.send( params );
			token.addResponder( this );
		}

		public function result(data:Object):void
		{
			if( data.result && 
			    data.result.error && 
			    data.result.error.hasOwnProperty('num_0') )
			{
				var isExpired : String =  String( data.result.error.num_0.desc.text() );
				if( isExpired.search( "EXPIRED" ) != -1 )
				{
					ExternalInterface.call( "expiredF" );
					return;
				}	
				responder.fault( data.result.error.num_0.desc.text() );
			}
			else if( data && data.result && data.result.result)
			{
				responder.result( data );
			}
		}
		
		public function fault(info:Object):void
		{
			responder.fault( info );
		}
		
	}
}