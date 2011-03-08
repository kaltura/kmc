package com.kaltura.kmc.modules.account.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.kmc.modules.account.model.states.WindowsStates;
	import com.kaltura.kmc.modules.account.vo.AccountUsageVO;
	import com.kaltura.kmc.modules.account.vo.AdminVO;
	import com.kaltura.kmc.modules.account.vo.FlavorVO;
	import com.kaltura.kmc.modules.account.vo.PackagesVO;
	import com.kaltura.kmc.modules.account.vo.PartnerVO;
	import com.kaltura.kmc.modules.account.vo.PaymentDetailsVO;
	import com.kaltura.kmc.modules.account.vo.UIConfVO;
	import com.kaltura.types.KalturaAccessControlOrderBy;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaAccessControlFilter;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUser;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class AccountModelLocator extends EventDispatcher implements IModelLocator {
		public static const USAGE_GRAPH_RESULT:String = "usageGraphResult";
		public static const USAGE_GRAPH_FAULT:String = "usageGraphFault";

		public var context:Context = null;
		public var uiConfigVo:UIConfVO = null;

		//---------------------------------------------------------
		//data objects
		[ArrayElementType("KalturaUser")]
		/**
		 * a list of users with administrator role of the current partner 
		 */		
		public var usersList:ArrayCollection;
		
		/**
		 * partner info 
		 */		
		public var partnerData:PartnerVO = new PartnerVO();
		
		public var partnerPackage:PackagesVO = null;
		public var adminData:AdminVO = new AdminVO();
		public var usageData:AccountUsageVO = new AccountUsageVO();
		public var paymentDetailsVo:PaymentDetailsVO = new PaymentDetailsVO();
		public var listPackages:ArrayCollection;
		public var modalWinData:Object = null;
		public var gaTrackUrl:String = null;
		
		public var metadataProfilesArray:ArrayCollection = new ArrayCollection();
		public var selectedMetadataProfile:KMCMetadataProfileVO;
		public var metadataFilterPager:KalturaFilterPager;
		public var metadataProfilesTotalCount:int = 10;
		//public var metadataProfile:KMCMetadataProfileVO = new KMCMetadataProfileVO();

		public var accessControlData:ArrayCollection = new ArrayCollection();

		public var accessControlProfilesTotalCount:int = 10;
		public var filterPager:KalturaFilterPager;
		public var acpFilter:KalturaAccessControlFilter;

		public var conversionData:ArrayCollection = new ArrayCollection();
		public var flavorsData:ArrayCollection = new ArrayCollection();
		public var thumbsData:ArrayCollection = new ArrayCollection();
		public var cpFilter:KalturaConversionProfileFilter;
		//---------------------------------------------------------
		//states
		public var windowState:String = WindowsStates.NONE;

		//---------------------------------------------------------
		//Flags 
		public var devFlag:Boolean = false;
		
		/**
		 * any pending server requests
		 */
		public var loadingFlag:Boolean = false;
		
		/**
		 * the custom metadata tab is disabled
		 * */
		public var customDataDisabled:Boolean = false;
		
		public var partnerInfoLoaded:Boolean = false;
		public var openPayPalWindowFlag:Boolean = false;
		public var saveAndExitFlag:Boolean = false;

		//---------------------------------------------------------
		//singleton methods
		private static var _modelLocator:AccountModelLocator;


		public static function getInstance():AccountModelLocator {
			if (_modelLocator == null) {
				_modelLocator = new AccountModelLocator(new Enforcer());
			}

			return _modelLocator;
		}


		public function AccountModelLocator(enforcer:Enforcer) {
			context = new Context();
			uiConfigVo = new UIConfVO();
			acpFilter = new KalturaAccessControlFilter();
			acpFilter.orderBy = KalturaAccessControlOrderBy.CREATED_AT_DESC;

			cpFilter = new KalturaConversionProfileFilter();
			//		cpFilter.orderBy = KalturaConversionProfileOrderBy.
		}


		public function getClonedFlavorsData():ArrayCollection {
			var arr:ArrayCollection = new ArrayCollection();
			for each (var flavor:FlavorVO in flavorsData) {
				arr.addItem(flavor.clone());
			}

			return arr;
		}


		public function getUnselectedClonedFlavorsData():ArrayCollection {
			var arr:ArrayCollection = new ArrayCollection();
			for each (var flavor:FlavorVO in flavorsData) {
				var cloned:FlavorVO = flavor.clone();
				cloned.selected = false;
				arr.addItem(cloned);
			}

			return arr;
		}
	}
}

class Enforcer {}