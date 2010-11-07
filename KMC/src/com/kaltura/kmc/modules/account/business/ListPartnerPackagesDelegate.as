package com.kaltura.kmc.modules.account.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.kaltura.kmc.modules.account.vo.PackagesVO;
	
	import flash.external.ExternalInterface;
	
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class ListPartnerPackagesDelegate implements IResponder
	{
		private var responder : IResponder;
		private var service : HTTPService;
	
		public function ListPartnerPackagesDelegate( responder : IResponder )
		{
			this.responder = responder;
			this.service = ServiceLocator.getInstance().getHTTPService( 'listPartnerPackagesSrv' );
		}
		
		public function listPartnerPackages( params : Object ) : void
		{
			var token : AsyncToken = service.send( params );
			token.addResponder( this );
		}
		
		private function getSupportType( type : int ) : String
		{
			//TODO: BREAK THE BITWISE OPPERATIONS
			switch( type )
			{
				case 1: return ResourceManager.getInstance().getString('kmc','communtySupport'); break;
				case 2: return ResourceManager.getInstance().getString('kmc','ticketSystem'); break;
				case 3: return ResourceManager.getInstance().getString('kmc','communtySupport') +", "+ResourceManager.getInstance().getString('kmc','ticketSystem'); break;
				case 4: return ResourceManager.getInstance().getString('kmc','email')+","+ResourceManager.getInstance().getString('kmc','email'); break;
				case 6: return ResourceManager.getInstance().getString('kmc','ticketSystem')+", "+ResourceManager.getInstance().getString('kmc','email'); break;
				case 8: return ResourceManager.getInstance().getString('kmc','phone'); break;
				case 14: return ResourceManager.getInstance().getString('kmc','ticketSystem')+", "+ResourceManager.getInstance().getString('kmc','email')+", "+ResourceManager.getInstance().getString('kmc','phone'); break;
			}
			
			return "";
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
				var xmlList : XMLList = data.result.result;
				var arr : Array = new Array();
				
				for each( var prop : XML in xmlList.packages.children())
				{
					var packageVo : PackagesVO = new PackagesVO();
					packageVo.pId = prop.id;
					packageVo.name = prop.name;
					packageVo.cycleType = prop.cycle_type.text();
					packageVo.cycleBw = prop.cycle_bw.text() + ResourceManager.getInstance().getString('kmc','perGb');
					packageVo.cycleFee =  prop.cycle_fee.text();
					packageVo.cycleFeeAsString = ResourceManager.getInstance().getString('kmc','dollarSign') + prop.cycle_fee.text();
					packageVo.overageFee = ResourceManager.getInstance().getString('kmc','dollarSign') + prop.overage_fee.text() + ResourceManager.getInstance().getString('kmc','perGb');
					packageVo.supportTypes = getSupportType( int(prop.support_types) );
					arr.push( packageVo );
				}
				
				responder.result( arr );
			}
			else
				responder.result( null );
		}
		
		public function fault(info:Object):void
		{
			responder.fault( info );
		}
	}
}