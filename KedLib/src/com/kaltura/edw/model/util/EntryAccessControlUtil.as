package com.kaltura.edw.model.util
{
	import mx.collections.ArrayCollection;
	import com.kaltura.vo.FlavorVO;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.utils.KCountriesUtil;
	import com.kaltura.vo.KalturaSiteRestriction;
	import com.kaltura.types.KalturaSiteRestrictionType;
	import mx.resources.ResourceManager;
	import mx.resources.IResourceManager;
	import com.kaltura.vo.KalturaIpAddressRestriction;
	import com.kaltura.types.KalturaIpAddressRestrictionType;
	import com.kaltura.vo.KalturaLimitFlavorsRestriction;
	import com.kaltura.types.KalturaLimitFlavorsRestrictionType;
	import com.kaltura.types.KalturaCountryRestrictionType;
	import com.kaltura.vo.KalturaCountryRestriction;
	import com.kaltura.edw.model.FilterModel;

	/**
	 * This class holds helper methods used in Entry Access Control section. 
	 * @author atar.shadmi
	 * @see modules.ked.EntryAccessControl
	 */
	public class EntryAccessControlUtil
	{
		private static var resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private static var _filterModel:FilterModel;
		
		public static function setModel(value:FilterModel):void {
			_filterModel = value;
		}
		
		public static function getSiteRestrictionText (rstrct:KalturaSiteRestriction):String {
			var result:String;
			if (rstrct.siteRestrictionType == KalturaSiteRestrictionType.ALLOW_SITE_LIST) {
				result = resourceManager.getString('drilldown', 'ALLOW_SITES') + ":  ";
			}
			else {
				result = resourceManager.getString('drilldown', 'RESTRICT_SITES') + ":  ";
			}
			result += rstrct.siteList;
			return result;
		}
		
		public static function getIPRestrictionText (rstrct:KalturaIpAddressRestriction):String {
			var result:String;
			if (rstrct.ipAddressRestrictionType == KalturaIpAddressRestrictionType.ALLOW_LIST) {
				result = resourceManager.getString('drilldown', 'ALLOW_IPS') + ":  ";
			}
			else {
				result = resourceManager.getString('drilldown', 'RESTRICT_IPS') + ":  ";
			}
			result += rstrct.ipAddressList;
			return result;
		}
		
		/**
		 * NOTE: filter model must be set before triggering this method 
		 * @param rstrct
		 * @return 
		 * 
		 */
		public static function getFlavorRestrictionText (rstrct:KalturaLimitFlavorsRestriction):String {
			var result:String;
			if (rstrct.limitFlavorsRestrictionType == KalturaLimitFlavorsRestrictionType.ALLOW_LIST) {
				result = resourceManager.getString('drilldown', 'ALLOW_FLAVORS') + ":  ";
			}
			else {
				result = resourceManager.getString('drilldown', 'RESTRICT_FLAVORS') + ":  ";
			}
			result += "\n";
			var tmp:Array = rstrct.flavorParamsIds.split(",");
			for each (var flavorParamsId:int in tmp) {
				result += getFlavorNameById(flavorParamsId) + ", ";
			}
			return result;
		}
		
		public static function getCountryRestrictionText (rstrct:KalturaCountryRestriction):String {
			var result:String;
			if (rstrct.countryRestrictionType == KalturaCountryRestrictionType.ALLOW_COUNTRY_LIST) {
				result = resourceManager.getString('drilldown', 'ALLOW_COUNTRIES') + ": "
			}
			else {
				result = resourceManager.getString('drilldown', 'RESTRICT_COUNTRIES') + ": ";
			}
			result += "\n" + EntryAccessControlUtil.getCountriesList(rstrct.countryList);
			
			return result;
		}
		
		private static function getFlavorNameById(flavorParamsId:int):String {
			for each (var kFlavor:KalturaFlavorParams in _filterModel.flavorParams) {
				if (kFlavor.id == flavorParamsId) {
					return kFlavor.name;
				}
			}
			return '';
		}
		
		/**
		 * filter model holds KalturaFlavorParams, but the window requires FlavorVOs.
		 * this method wraps each KalturaFlavorParams in FlavorVO like Account module does.
		 * */
		public static function wrapInFlavorVo(ac:ArrayCollection):ArrayCollection {
			var tempArrCol:ArrayCollection = new ArrayCollection();
			var flavor:FlavorVO;
			for each(var kFlavor:Object in ac) {
				if (kFlavor is KalturaFlavorParams) {
					flavor = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					tempArrCol.addItem(flavor);
				}
			}
			return tempArrCol;
		}
		
		
		public static function getCountriesList(countriesCodesList:String):String {
			var cArr:Array = countriesCodesList.split(',');
			var countriesList:String = '';
			for each (var countryCode:String in cArr) {
				countriesList += KCountriesUtil.instance.getCountryName(countryCode) + ', ';
			}
			
			return countriesList.substr(0, countriesList.length - 2);
		}
		
		
		/**
		 * show profile name in profiles dropdown 
		 * @param item
		 * @return 
		 * 
		 */
		public static function dropdownLabelFunction(item:Object):String {
			return item.profile.name;
		}
	}
}