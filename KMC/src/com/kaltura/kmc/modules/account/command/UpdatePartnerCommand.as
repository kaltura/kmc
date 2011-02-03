package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.NotificationVO;
	import com.kaltura.vo.KalturaPartner;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class UpdatePartnerCommand implements ICommand
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			 
			var kp:KalturaPartner = new KalturaPartner();
			//kp.adminEmail = _model.partnerData.adminEmail;	
			//kp.adminName = _model.partnerData.adminName;
			kp.adultContent = _model.partnerData.adultContent;
			kp.allowQuickEdit = _model.partnerData.allowQuickEdit ? 1 : 0;
			kp.appearInSearch = _model.partnerData.appearInSearch;	
			kp.contentCategories = _model.partnerData.contentCategories;
			kp.defConversionProfileType = _model.partnerData.defConversionProfileType;
			kp.describeYourself = _model.partnerData.describeYourself;
			kp.description = _model.partnerData.description;
			kp.id =  int(_model.partnerData.pId);
			kp.landingPage = _model.partnerData.landingPage;
			kp.maxUploadSize = _model.partnerData.maxUploadSize; 
			kp.mergeEntryLists = _model.partnerData.mergeEntryLists ? 1 : 0;
	 		kp.name = _model.partnerData.name;
			kp.notificationsConfig = getNotificationsConfig(_model.partnerData.notifications);
			kp.notificationUrl =  _model.partnerData.url2;
			kp.notify = _model.partnerData.notify ? 1 : 0;
			kp.partnerPackage = _model.partnerData.partnerPackage;
			kp.phone = _model.partnerData.phone;
			kp.secret =  _model.partnerData.secret;
	 		kp.status = _model.partnerData.status;
			kp.type = _model.partnerData.type;
			kp.uid =  _model.partnerData.subPId;
			kp.userLandingPage = _model.partnerData.userLandingPage;
			kp.website = _model.partnerData.url1;
			kp.adminUserId = _model.partnerData.accountOwnerId;
			
			var updatePartner:PartnerUpdate = new PartnerUpdate(kp, true);
			updatePartner.addEventListener(KalturaEvent.COMPLETE, result);
			updatePartner.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updatePartner);	
		}
		
		private function getNotificationsConfig( notifications : ArrayCollection ) : String
		{
			var str : String = "*=0;"
			for(var i:int=0; i < notifications.length ; i++)
			{
				var nvo : NotificationVO = notifications[i] as NotificationVO;
				var res : int = 0;
				
				if(nvo.availableInServer && nvo.availableInClient && nvo.clientEnabled)
					res = 3;
				else if(nvo.availableInClient && nvo.clientEnabled)
					res = 2;
				else if( nvo.availableInServer )
					res = 1;
				else
					res = 0;	
				
				str += nvo.nId +"="+res+";";	
			}
			return str;
		}
		
//		public function closeAlert( alertRef : Alert ) : void
//		{
//			PopUpManager.removePopUp( alertRef );
//		}
		
		private function result(data:Object):void
		{
			KalturaPartner(data.data);
			_model.loadingFlag = false;
			if(_model.saveAndExitFlag)
			{
				JSGate.onTabChange();
				return;
			}
			
			var alert : Alert =  Alert.show( ResourceManager.getInstance().getString('account', 'changesSaved') );
//			setTimeout( closeAlert , 3000 , alert);
		}
		
		private function fault(info:Object):void
		{
			_model.loadingFlag = false;			
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				JSGate.expired();
				return;
			}
			var alert : Alert =  Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
//			setTimeout( closeAlert , 3000 , alert);
		}
	}
}