package com.kaltura.vo {
	import com.adobe.cairngorm.vo.IValueObject;
	
	import mx.utils.ObjectProxy;

	[Bindable]
	/**
	 * This class is a wrapper for the KalturaAccessControl VO.
	 */
	public class AccessControlProfileVO extends ObjectProxy implements IValueObject {
		
		
		public static const SELECTED_CHANGED_EVENT:String = "accessControlSelectedChanged";


		/**
		 *  KalturaAccessControl VO, hold all the profile properties
		 */
		public var profile:KalturaAccessControl;
		
		/**
		 * id of the wrapped profile 
		 */		
		public var id:int;


		/**
		 * Constructor
		 *
		 */
		public function AccessControlProfileVO() {
//			profile = new KalturaAccessControl();
		}



		/**
		 * Creates a AccessControlProfileVO
		 * @return a new AccessControlProfileVO object
		 *
		 */
		public function clone():AccessControlProfileVO {
			var newAcp:AccessControlProfileVO = new AccessControlProfileVO();
			newAcp.profile.name = this.profile.name.slice();
			newAcp.profile.description = this.profile.description.slice();
			newAcp.profile.createdAt = this.profile.createdAt;
			newAcp.profile.id = this.profile.id;
			newAcp.profile.isDefault = this.profile.isDefault;
			newAcp.profile.restrictions = new Array();

			for each (var restriction:KalturaBaseRestriction in this.profile.restrictions) {
				if (restriction is KalturaSiteRestriction) {
					var ksr:KalturaSiteRestriction = new KalturaSiteRestriction();
					ksr.siteRestrictionType = (restriction as KalturaSiteRestriction).siteRestrictionType;
					ksr.siteList = (restriction as KalturaSiteRestriction).siteList;
					newAcp.profile.restrictions.push(ksr);
				}
				else if (restriction is KalturaCountryRestriction) {
					var kcr:KalturaCountryRestriction = new KalturaCountryRestriction();
					kcr.countryRestrictionType = (restriction as KalturaCountryRestriction).countryRestrictionType;
					kcr.countryList = (restriction as KalturaCountryRestriction).countryList;
					newAcp.profile.restrictions.push(kcr);
				}
				else if (restriction is KalturaPreviewRestriction) {
					var kpr:KalturaPreviewRestriction = new KalturaPreviewRestriction();
					kpr.previewLength = (restriction as KalturaPreviewRestriction).previewLength;
					newAcp.profile.restrictions.push(kpr);
				}
				else if (restriction is KalturaSessionRestriction) {
					var kser:KalturaSessionRestriction = new KalturaSessionRestriction();
					newAcp.profile.restrictions.push(kser);
				}
				else if (restriction is KalturaDirectoryRestriction) {
					var kdr:KalturaDirectoryRestriction = new KalturaDirectoryRestriction();
					kdr.directoryRestrictionType = (restriction as KalturaDirectoryRestriction).directoryRestrictionType;
					newAcp.profile.restrictions.push(kdr);
				}
				else if (restriction is KalturaIpAddressRestriction) {
					var kir:KalturaIpAddressRestriction = new KalturaIpAddressRestriction();
					kir.ipAddressRestrictionType = (restriction as KalturaIpAddressRestriction).ipAddressRestrictionType;
					kir.ipAddressList = (restriction as KalturaIpAddressRestriction).ipAddressList;
					newAcp.profile.restrictions.push(kir);
				}
			}


			return newAcp;
		}

	}
}
