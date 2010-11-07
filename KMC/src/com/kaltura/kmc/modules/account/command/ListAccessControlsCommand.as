package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.vo.AccessControlProfileVO;
	import com.kaltura.vo.KalturaAccessControl;
	import com.kaltura.vo.KalturaAccessControlListResponse;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListAccessControlsCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var getListAccessControlProfiles:AccessControlList = new AccessControlList(_model.acpFilter, _model.filterPager);
		 	getListAccessControlProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			getListAccessControlProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListAccessControlProfiles);	
		}
		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			
			if(data.success)
			{
				var tempArr:ArrayCollection = new ArrayCollection();
				var response:KalturaAccessControlListResponse = data.data as KalturaAccessControlListResponse;
				_model.accessControlProfilesTotalCount = response.totalCount;
				_model.accessControlData = new ArrayCollection();
				for each(var kac:KalturaAccessControl in response.objects)
				{
					var acVo:AccessControlProfileVO = new AccessControlProfileVO();
					acVo.profile = kac;
					if(acVo.profile.isDefault)
					{
						tempArr.addItemAt(acVo, 0);
					}
					else
					{
						tempArr.addItem(acVo);
					}
				}
				_model.accessControlData = tempArr;
			}
			else
			{
				Alert.show(data.error, ResourceManager.getInstance().getString('account', 'error'));
			}
		
			/* var acProfile1:AccessControlProfileVO = new AccessControlProfileVO();
			acProfile1.profile.id = 1;
			acProfile1.profile.name = "Default 1";
			acProfile1.profile.description = "Default Access Control Profile";
			
			var kSitesR1:KalturaSiteRestriction = new KalturaSiteRestriction();
			kSitesR1.siteRestrictionType = KalturaSiteRestrictionType.ALLOW_SITE_LIST;
			kSitesR1.siteList = "domain1.com,domain2.com,domain10.com,domain20.com,domain100.com,domain200.com";
			
			var kCountriesR1:KalturaCountryRestriction = new KalturaCountryRestriction();
			kCountriesR1.countryRestrictionType = KalturaCountryRestrictionType.ALLOW_COUNTRY_LIST;
			kCountriesR1.countryList = "il,ir,it";
			
			var kSessionR1:KalturaSessionRestriction = new KalturaSessionRestriction();
			
			var kPreviewR1:KalturaPreviewRestriction = new KalturaPreviewRestriction();
			kPreviewR1.previewLength = 230;
			
			var kDirectoryR1:KalturaDirectoryRestriction = new KalturaDirectoryRestriction();
			kDirectoryR1.directoryRestrictionType = KalturaDirectoryRestrictionType.DISPLAY_WITH_LINK;
			
			acProfile1.profile.restrictions.push(kSitesR1, kCountriesR1, kSessionR1, kPreviewR1, kDirectoryR1);
			
			var acProfile2:AccessControlProfileVO = new AccessControlProfileVO();
			acProfile2.profile.id = 2;
			acProfile2.profile.name = "Default 2";
			acProfile2.profile.description = "Default Access Control Profile 2";
			
			var kSitesR2:KalturaSiteRestriction = new KalturaSiteRestriction();
			kSitesR2.siteRestrictionType = KalturaSiteRestrictionType.RESTRICT_SITE_LIST;
			kSitesR2.siteList = "domain3.com,domain4.com";
			
			var kCountriesR2:KalturaCountryRestriction = new KalturaCountryRestriction();
			kCountriesR2.countryRestrictionType = KalturaCountryRestrictionType.RESTRICT_COUNTRY_LIST;
			kCountriesR2.countryList = "us,gr,se";
			
			var kSessionR2:KalturaSessionRestriction = new KalturaSessionRestriction();
			
			var kPreviewR2:KalturaPreviewRestriction = new KalturaPreviewRestriction();
			kPreviewR2.previewLength = 126;
			
			var kDirectoryR2:KalturaDirectoryRestriction = new KalturaDirectoryRestriction();
			kDirectoryR2.directoryRestrictionType = KalturaDirectoryRestrictionType.DONT_DISPLAY;
			
			acProfile2.profile.restrictions.push(kSitesR2, kCountriesR2, kSessionR2, kPreviewR2, kDirectoryR2);
			
			var acProfile3:AccessControlProfileVO = new AccessControlProfileVO();
			acProfile3.profile.id = 3;
			acProfile3.profile.name = "Default 3";
			acProfile3.profile.description = "Default Access Control Profile 3";
	//		var kSitesR3:KalturaBaseRestriction = new KalturaBaseRestriction();
	//		var kCountriesR3:KalturaBaseRestriction = new KalturaBaseRestriction();
	//		var kSessionR3:KalturaBaseRestriction = new KalturaBaseRestriction();
	//		var kPreviewR3:KalturaBaseRestriction = new KalturaBaseRestriction();
	//		var kDirectoryR3:KalturaBaseRestriction = new KalturaBaseRestriction();
			acProfile3.profile.restrictions.push();//kCountriesR3, kSessionR3, kPreviewR3, kDirectoryR3);
			
			var acProfile4:AccessControlProfileVO = new AccessControlProfileVO();
			acProfile4.profile.id = 4;
			acProfile4.profile.name = "Default 4";
			acProfile4.profile.description = "Default Access Control Profile 4";
			var kSitesR4:KalturaBaseRestriction = new KalturaBaseRestriction();
			var kCountriesR4:KalturaBaseRestriction = new KalturaBaseRestriction();
			var kSessionR4:KalturaSessionRestriction = new KalturaSessionRestriction();
			var kPreviewR4:KalturaBaseRestriction = new KalturaBaseRestriction();
			var kDirectoryR4:KalturaBaseRestriction = new KalturaBaseRestriction();
			acProfile4.profile.restrictions.push(kSitesR4, kCountriesR4, kSessionR4, kPreviewR4, kDirectoryR4);
			
			_model.accessControlData.addItem(acProfile1);
			_model.accessControlData.addItem(acProfile2);
			_model.accessControlData.addItem(acProfile3);
			_model.accessControlData.addItem(acProfile4);
			
			 */
			_model.partnerInfoLoaded = true;
		}
		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			_model.loadingFlag = false;
			Alert.show(ResourceManager.getInstance().getString('kmc', 'notLoadAccessControl') + "\n\t" + info.error.errorMsg, ResourceManager.getInstance().getString('kmc', 'error'));
		}
		

	}
}