package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.kaltura.kmc.modules.analytics.model.Notifications;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class PartnerVO implements IValueObject
	{
		public var pId : String = "";
		public var subPId : String = "";
		public var secret : String = "";
		public var adminSecret : String = "";
		public var name : String = "";
		public var url1 : String = "";
		public var url2 : String = "";
		public var appearInSearch : int = 0;
		public var createdAt : String = "";
		public var adminName : String = "";
		public var adminEmail : String = "";
		public var phone : String = "";
		public var description : String = "";
		public var commercialUse : int;
		public var type : int;
 		public var adultContent : Boolean = false;
 		public var notify : Boolean = false;
 		public var notificationsConfig : String = "";
 		public var contentCategories : String = "";
 		public var describeYourself : String = "";
 		public var allowMultiNotification : Boolean = true;
 		public var defConversionProfileType : String = "";
		public var shouldForceUniqueKshow : Boolean = false ;   
		public var returnDuplicateKshow : Boolean = false;    
		public var allowQuickEdit : Boolean = false;    
		public var mergeEntryLists : Boolean = false;    
		public var userLandingPage : String = "";   
		public var landingPage : String = "";  
		public var maxUploadSize : Number = 150;  
		public var allowEmptyField : Boolean = false;    
		public var notifications : ArrayCollection = new ArrayCollection();
		public var createdYear : uint = 2008;
		public var createdMonth : uint = 1;
		public var createdDay : uint = 1;
		public var partnerPackage : uint = 0;
		public var status : uint = 0;
		
			
		public function PartnerVO()
		{
			for( var key : String in Notifications.notificationMap)
			{
				var noti : NotificationVO = new NotificationVO();
				noti.nId = key;
				noti.name = Notifications.notificationMap[key].name;
				noti.clientEnabled = Notifications.notificationMap[key].clientEnabled;
				this.notifications.addItem( noti );
			}
		}
		
		public function clone() : PartnerVO
		{
			var newPVo : PartnerVO = new PartnerVO();
			newPVo.pId = this.pId;
			newPVo.subPId = this.subPId;
			newPVo.secret =  this.secret;
			newPVo.adminSecret =  this.adminSecret;
			newPVo.name = this.name;
			newPVo.url1 = this.url1;
			newPVo.url2 = this.url2;
			newPVo.appearInSearch = this.appearInSearch;
			newPVo.createdAt = this.createdAt;
			newPVo.adminName = this.adminName;
			newPVo.adminEmail = this.adminEmail;
			newPVo.phone = this.phone; 
			newPVo.description = this.description;
			newPVo.commercialUse = this.commercialUse;
			newPVo.type = this.type; 
			newPVo.adultContent = this.adultContent;
			newPVo.secret = this.secret;
			newPVo.adminSecret = this.adminSecret;
			newPVo.contentCategories = this.contentCategories;
			newPVo.describeYourself = this.describeYourself;
			newPVo.notificationsConfig = this.notificationsConfig;
			newPVo.allowMultiNotification = this.allowMultiNotification;
			newPVo.defConversionProfileType = this.defConversionProfileType;
			newPVo.shouldForceUniqueKshow = this.shouldForceUniqueKshow;
			newPVo.returnDuplicateKshow = this.returnDuplicateKshow;
			newPVo.allowQuickEdit = this.allowQuickEdit;
			newPVo.mergeEntryLists = this.mergeEntryLists;
			newPVo.userLandingPage = this.userLandingPage;
			newPVo.landingPage = this.landingPage;
			newPVo.maxUploadSize = this.maxUploadSize;
			newPVo.allowEmptyField = this.allowEmptyField;
			newPVo.notify = this.notify;
			newPVo.createdDay = this.createdDay;
			newPVo.createdMonth = this.createdMonth;
			newPVo.createdYear = this.createdYear;
			newPVo.partnerPackage = this.partnerPackage;
			newPVo.status = this.status;
			newPVo.notifications = new ArrayCollection(new Array(int(this.notifications.length)));
			
			for( var i:int = 0 ; i < this.notifications.length ; i++)
			{
				newPVo.notifications[i] = new NotificationVO();
				newPVo.notifications[i].availableInClient = this.notifications[i].availableInClient;
				newPVo.notifications[i].availableInServer = this.notifications[i].availableInServer;
				newPVo.notifications[i].nId = this.notifications[i].nId;
				newPVo.notifications[i].name = this.notifications[i].name;
				newPVo.notifications[i].clientEnabled != this.notifications[i].clientEnabled;
			}
			
			return newPVo;
		}
		
		public function equals( newPVo : PartnerVO) : Boolean
		{
			if(!newPVo)
				return false;
				
			var isIt : Boolean = true;
			if( newPVo.pId != this.pId ) isIt = false;
			if( newPVo.subPId != this.subPId ) isIt = false;
			if( newPVo.secret != this.secret ) isIt = false;
			if( newPVo.adminSecret != this.adminSecret ) isIt = false;
			if( newPVo.name != this.name ) isIt = false;
			if( newPVo.url1 != this.url1 ) isIt = false;
			if( newPVo.url2 != this.url2 ) isIt = false;
			if( newPVo.appearInSearch != this.appearInSearch) isIt = false;
			if( newPVo.createdAt != this.createdAt) isIt = false;
			if( newPVo.adminName != this.adminName) isIt = false;
			if( newPVo.adminEmail != this.adminEmail) isIt = false;
			if( newPVo.phone != this.phone) isIt = false;
			if( newPVo.description != this.description )  isIt = false;
			if( newPVo.commercialUse != this.commercialUse) isIt = false;
			if( newPVo.type != this.type)isIt = false; 
			if( newPVo.adultContent != this.adultContent) isIt = false;
			if( newPVo.secret != this.secret) isIt = false;
			if( newPVo.adminSecret != this.adminSecret) isIt = false;
			if( newPVo.contentCategories != this.contentCategories) isIt = false;
			if( newPVo.notificationsConfig != this.notificationsConfig) isIt = false;
			if( newPVo.describeYourself != this.describeYourself) isIt = false;	
			if( newPVo.allowMultiNotification != this.allowMultiNotification) isIt = false;			
			if( newPVo.defConversionProfileType != this.defConversionProfileType) isIt = false;	
			if( newPVo.shouldForceUniqueKshow != this.shouldForceUniqueKshow) isIt = false;	
			if( newPVo.returnDuplicateKshow != this.returnDuplicateKshow) isIt = false;	
			if( newPVo.allowQuickEdit != this.allowQuickEdit) isIt = false;	
			if( newPVo.mergeEntryLists != this.mergeEntryLists) isIt = false;	
			if( newPVo.userLandingPage != this.userLandingPage) isIt = false;	
			if( newPVo.landingPage != this.landingPage) isIt = false;	
			if( newPVo.maxUploadSize != this.maxUploadSize) isIt = false;
			if( newPVo.allowEmptyField != this.allowEmptyField) isIt = false;
			if( newPVo.notify != this.notify ) isIt = false;		
			if( newPVo.partnerPackage != this.partnerPackage ) isIt = false;
			if( newPVo.createdDay != this.createdDay) isIt = false;		
			if( newPVo.createdMonth != this.createdMonth) isIt = false;		
			if( newPVo.createdYear != this.createdYear) isIt = false;
			if( newPVo.status != this.status) isIt = false;			

			for( var i:int = 0 ; i < this.notifications.length ; i++)
			{
				if(newPVo.notifications[i].availableInClient != this.notifications[i].availableInClient) isIt = false;
				if(newPVo.notifications[i].availableInServer != this.notifications[i].availableInServer) isIt = false;
				if(newPVo.notifications[i].nId != this.notifications[i].nId) isIt = false;
				if(newPVo.notifications[i].name != this.notifications[i].name) isIt = false;
			}			

			return isIt;
		}
	}
}