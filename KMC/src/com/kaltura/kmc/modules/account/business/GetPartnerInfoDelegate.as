package com.kaltura.kmc.modules.account.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.kaltura.kmc.modules.account.vo.NotificationVO;
	import com.kaltura.kmc.modules.account.vo.PartnerVO;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class GetPartnerInfoDelegate implements IResponder
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function GetPartnerInfoDelegate( responder : IResponder )
		{
			this.responder = responder;
			this.service = ServiceLocator.getInstance().getHTTPService( 'getPartnerInfoSrv' );
		}
		
		public function getPartnerInfo( params : Object ) : void
		{
			var token : AsyncToken = service.send( params );
			token.addResponder( this );
			
			
		}
		
		private function createNotificationArray( str : String , arrCol : ArrayCollection ) : void
		{
			var tempNotiArray : Array = str.split(";");
			var i:int=0;
			switch(tempNotiArray[0]) //set the notification to *=0 and make the changes needed
			{
				case "*=0": 
					for( i=0 ; i < arrCol.length ; i++)
					{
						(arrCol[i] as NotificationVO).availableInClient = false;
						(arrCol[i] as NotificationVO).availableInServer = false;
					}
				break; //all off
				case "*=1": //all server on
					for( i=0 ; i < arrCol.length ; i++)
					{
						(arrCol[i] as NotificationVO).availableInClient = false;
						(arrCol[i] as NotificationVO).availableInServer = true;
					}
				break; 
				case "*=2":  //all client on
					for( i=0 ; i < arrCol.length ; i++)
					{
						(arrCol[i] as NotificationVO).availableInClient = false;
						(arrCol[i] as NotificationVO).availableInServer = true;
					}
				break;
				case "*=3": 
					for( i=0 ; i < arrCol.length ; i++)
					{
						(arrCol[i] as NotificationVO).availableInClient = true;
						(arrCol[i] as NotificationVO).availableInServer = true;
					}
				break; //all on
			}
			
			for(i=1; i<tempNotiArray.length; i++)
			{
				var keyValArr : Array = tempNotiArray[i].split("=");
				for(var j:int=0; j<arrCol.length ; j++)
				{
					if((arrCol[j] as NotificationVO).nId == keyValArr[0])
					{
						switch(keyValArr[1])
						{
							case "0": 
								(arrCol[j] as NotificationVO).availableInClient = false;
								(arrCol[j] as NotificationVO).availableInServer = false;
							break;
							case "1": 
								(arrCol[j] as NotificationVO).availableInClient = false;
								(arrCol[j] as NotificationVO).availableInServer = true;
							break;
							case "2": 
								(arrCol[j] as NotificationVO).availableInClient = true;
								(arrCol[j] as NotificationVO).availableInServer = false;
							break;
							case "3": 
								(arrCol[j] as NotificationVO).availableInClient = true;
								(arrCol[j] as NotificationVO).availableInServer = true;
							break;
						}
					}
				}
			}
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
				
				var partnerVo : PartnerVO = new PartnerVO();
				partnerVo.adminEmail = xmlList.partner.adminEmail;
				partnerVo.adminName = xmlList.partner.adminName;
				partnerVo.adminSecret = xmlList.partner.adminSecret;
				partnerVo.adultContent = xmlList.partner.adultContent == 1 ? true : false;  
				partnerVo.appearInSearch = xmlList.partner.appearInSearch;
				partnerVo.commercialUse = xmlList.partner.commercialUse;
				partnerVo.describeYourself = xmlList.partner.describeYourself;
				partnerVo.contentCategories = xmlList.partner.contentCategories;
				partnerVo.createdAt = xmlList.partner.createdAt;
				partnerVo.partnerPackage = xmlList.partner.partnerPackage;
				
				var dateArr : Array = (partnerVo.createdAt).split('-');
				partnerVo.createdYear = dateArr[0];
				partnerVo.createdMonth = dateArr[1];
				partnerVo.createdDay = uint(String(dateArr[2]).substr(0,2));
				
				partnerVo.description = xmlList.partner.description;
				partnerVo.notificationsConfig = xmlList.partner.notificationsConfig;
				
				createNotificationArray( partnerVo.notificationsConfig  , partnerVo.notifications);
				
				partnerVo.pId = xmlList.partner.id;
				partnerVo.name = xmlList.partner.name;
				partnerVo.phone = xmlList.partner.phone;
				partnerVo.secret = xmlList.partner.secret;
				partnerVo.type = xmlList.partner.type;
				partnerVo.url1 = xmlList.partner.url1;
				partnerVo.url2 = xmlList.partner.url2;
				
				partnerVo.defConversionProfileType = xmlList.partner.defConversionProfileType; 
				partnerVo.notify = xmlList.partner.notify == 1 ? true : false;  
				partnerVo.shouldForceUniqueKshow = xmlList.partner.shouldForceUniqueKshow == 1 ? true : false;  
				partnerVo.returnDuplicateKshow = xmlList.partner.returnDuplicateKshow == 1 ? true : false;    
				partnerVo.allowQuickEdit = xmlList.partner.allowQuickEdit == 1 ? true : false;
				partnerVo.mergeEntryLists = xmlList.partner.mergeEntryLists == 1 ? true : false;
				partnerVo.userLandingPage = xmlList.partner.userLandingPage.children()[0];
				partnerVo.landingPage = xmlList.partner.landingPage.children()[0];   
				partnerVo.maxUploadSize = xmlList.partner.maxUploadSize; 
				partnerVo.status = xmlList.partner.status;
				
				responder.result( partnerVo );
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