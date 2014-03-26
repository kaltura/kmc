package com.kaltura.kmc.modules.analytics.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.kmc.modules.analytics.business.IDateRangeManager;
	import com.kaltura.kmc.modules.analytics.business.LongTermRangeManager;
	import com.kaltura.kmc.modules.analytics.business.ShortTermRangeManager;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.reports.AggregateHeaders;
	import com.kaltura.kmc.modules.analytics.model.reports.FilterMasks;
	import com.kaltura.kmc.modules.analytics.model.reports.ReportDimension;
	import com.kaltura.kmc.modules.analytics.model.reports.TableHeaders;
	import com.kaltura.kmc.modules.analytics.model.reports.UnsortableColumnHeaders;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.vo.AccountUsageVO;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	import com.kaltura.kmc.modules.analytics.vo.PartnerVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	import com.kaltura.edw.vo.LocalizedVo;

	[Bindable]
	public class AnalyticsModelLocator implements IModelLocator {

		/**
		 * the hour 23:59 in seconds
		 */
		public const END_OF_DAY_IN_SECONDS:Number = 86399;

		/**
		 * kaltura client that make all kaltura API calls
		 */
		public var kc:KalturaClient;

		/**
		 * application context data
		 */
		public var context:Context = null;

		//---------------------------------------------------------

		/**
		 * the uiconf that the loaded KDP uses
		 */
		public var kdpUiConf:String;

		//---------------------------------------------------------
		//data objects
		
		
		/**
		 * the name of subject (user name, entry name) of current drilldown (shown in breadcrumps)
		 */
		public var drillDownName:String = "";
		
		/**
		 * keys are screen types, values are ReportData object 
		 */
		public var reportDataMap:Object = new Object();

		/**
		 * data of currently shown report
		 */
		public var selectedReportData:ReportData;
		public var partnerData:PartnerVO = new PartnerVO();
		public var usageData:AccountUsageVO = new AccountUsageVO();
		
		public var reportDimension:ReportDimension = new ReportDimension();
		public var aggregateHeaders:AggregateHeaders = new AggregateHeaders();
		public var tableHeaders:TableHeaders = new TableHeaders();
		public var tableNonSortableHeaders:UnsortableColumnHeaders = new UnsortableColumnHeaders();
		
		public var filterMasks:FilterMasks = new FilterMasks(new FilterVo());
		
		/**
		 * get the filter for the current screen 
		 */
		public function get filter():FilterVo {
			return getFilterForScreen(currentScreenState);
		}

		/**
		 * get a filter vo according to given screen
		 * @param screenType as enumerated in ScreenTypes
		 * @return filter vo through required mask
		 * 
		 * @see com.kaltura.kmc.modules.analytics.model.types.ScreenTypes
		 */		
		public function getFilterForScreen(screenType:int):FilterVo {
			var res:FilterVo;
			// get correct mask according to current report
			switch (screenType) {
				case ScreenTypes.TOP_CONTENT :
					res = filterMasks.topContent;
					break;
				case ScreenTypes.CONTENT_DROPOFF :
					res = filterMasks.contentDropoff;
					break;
				case ScreenTypes.CONTENT_INTERACTIONS :
					res = filterMasks.contentInteraction;
					break;
				case ScreenTypes.CONTENT_CONTRIBUTIONS :
					res = filterMasks.contentContributions;
					break;
				case ScreenTypes.VIDEO_DRILL_DOWN_DEFAULT :
					res = filterMasks.topContentPerUser;
					break;
				case ScreenTypes.VIDEO_DRILL_DOWN_DROP_OFF :
					res = filterMasks.contentDropoffPerUser;
					break;
				case ScreenTypes.VIDEO_DRILL_DOWN_INTERACTIONS :
					res = filterMasks.contentInteractionPerUser;
					break;
				case ScreenTypes.CONTENT_CONTRIBUTIONS_DRILL_DOWN :
					res = filterMasks.contentContributions;
					break;
				
				case ScreenTypes.TOP_CONTRIBUTORS :
					res = filterMasks.topContrib;
					break;
				case ScreenTypes.MAP_OVERLAY :
					res = filterMasks.mapOverlay;
					break;
				case ScreenTypes.TOP_SYNDICATIONS :
					res = filterMasks.syndicator;
					break;
				case ScreenTypes.TOP_SYNDICATIONS_DRILL_DOWN  :
					res = filterMasks.syndicator;
					break;
				case ScreenTypes.MAP_OVERLAY_DRILL_DOWN  : 
					res = filterMasks.mapOverlay;
					break;
				
				case ScreenTypes.END_USER_ENGAGEMENT  :
					res = filterMasks.userEngagement;
					break;
				case ScreenTypes.END_USER_ENGAGEMENT_DRILL_DOWN  :
					res = filterMasks.userEngagementDrilldown;
					break;
				
				case ScreenTypes.PARTNER_BANDWIDTH_AND_STORAGE :
					res = filterMasks.publisherBandwidthNStorage;
					break;
				case ScreenTypes.END_USER_STORAGE :
					res = filterMasks.endUserStorage;
					break;
				case ScreenTypes.END_USER_STORAGE_DRILL_DOWN :
					res = filterMasks.specificEndUserStorage;  
					break;
				
				case ScreenTypes.PLATFORM :
					res = filterMasks.platforms;
					break;
				case ScreenTypes.PLATFORM_DRILL_DOWN :
					res = filterMasks.platforms;
					break;
				case ScreenTypes.OS :
					res = filterMasks.opsys;  
					break;
				case ScreenTypes.BROWSER :
					res = filterMasks.browsers;  
					break;
				case ScreenTypes.LIVE_CONTENT:
					res = filterMasks.liveContent;  
					break;
			}
			return res;
		}
		

		
		/**
		 * id of drilldown subject (user / entry)
		 */
		public var selectedEntry:String;
		
		/**
		 * does ktable show links for items 
		 */
		public var tableSupportDrillDown:Boolean = true;
		
		/**
		 * should referer icon be shown in ktable
		 */
		public var showRefererIcon:Boolean = false;

		
		/**
		 * dates ranges manager for content / users reports 
		 */
		public var shortTermDatesRanger:IDateRangeManager = new ShortTermRangeManager();
		
		/**
		 * dates ranges manager for BW & storage reports 
		 */		
		public var longTermDatesRanger:IDateRangeManager = new LongTermRangeManager();
		
		
		public var categories:ArrayCollection;
		
		public var categoriesMap:HashMap = new HashMap();
		
		public var categoriesFullNameList:ArrayCollection = new ArrayCollection();

		/**
		 * Set to enable disable entitlement feature in analytics
		 * and by that hide/show the relevent UI
		 */
		public var entitlementEnabled:Boolean = true;

		/**
		 * All the applications of the partner is listed here
		 */
		public var applicationsList:ArrayCollection = new ArrayCollection();

		/**
		 * dataprovider for content reports tab sub-navigation
		 */
		public var contentDtnDp:ArrayCollection = new ArrayCollection([
			new LocalizedVo('topContent', 'topContent', 'analytics'),
			new LocalizedVo('contentDropOff', 'contentDropOff', 'analytics'),
			new LocalizedVo('contentInteractions', 'contentInteractions', 'analytics'),
			new LocalizedVo('contentContributions', 'contentContributions', 'analytics')]);


		/**
		 * dataprovider for the community reports tab sub-navigation
		 */
		public function get userDtnDp():ArrayCollection {
			if (entitlementEnabled) {
				return new ArrayCollection([
					ResourceManager.getInstance().getString('analytics', 'topContributors'),
					ResourceManager.getInstance().getString('analytics', 'mapOverlay'),
					ResourceManager.getInstance().getString('analytics', 'topSyndications'),
					ResourceManager.getInstance().getString('analytics', 'userEngagement')]);
			}
			else {
				return new ArrayCollection([
					ResourceManager.getInstance().getString('analytics', 'topContributors'),
					ResourceManager.getInstance().getString('analytics', 'mapOverlay'),
					ResourceManager.getInstance().getString('analytics', 'topSyndications')]);
			}
		}



		public function get usageDtnDp():ArrayCollection {
			if (entitlementEnabled) {
				return new ArrayCollection(
					[ResourceManager.getInstance().getString('analytics', 'pbns'),
					ResourceManager.getInstance().getString('analytics', 'endUserStorage')]);
			}
			else {
				return new ArrayCollection(
					[ResourceManager.getInstance().getString('analytics', 'pbns')]);
			}
		}
		
		/**
		 * dataprovider for platform reports tab sub-navigation
		 */
		public var platformDtnDp:ArrayCollection = new ArrayCollection([
			new LocalizedVo('platforms', 'platforms', 'analytics'),
			new LocalizedVo('opsyss', 'opsyss', 'analytics'),
			new LocalizedVo('browsers', 'browsers', 'analytics')]);

		
		/**
		 * dataprovider for live content reports tab sub-navigation
		 */
		public var liveDtnDp:ArrayCollection = new ArrayCollection([
			new LocalizedVo('liveContent', 'liveContent', 'analytics')]);


		//---------------------------------------------------------
		/**
		 * current showing screen, enumerated in <code>ScreenTypes</code>.
		 */
		public var currentScreenState:int = ScreenTypes.TOP_CONTENT;

		//---------------------------------------------------------
		//Flags 
		/**
		 * general loading flag.  
		 * commands should set to true when calling API together with partial load  flag, then  
		 * reset the partial load flag and call checkLoading() to update the general flag.
		 */
		public var loadingFlag:Boolean = false;
		public var loadingChartFlag:Boolean = false;
		public var loadingTableFlag:Boolean = false;
		public var loadingTotalFlag:Boolean = false;
		public var loadingEntryFlag:Boolean = false;
		public var loadingApplicationsFlag:Boolean = false;
		public var loadingBaseTotals:Boolean = false;
		public var loadingCategories:Boolean = false;
		public var loadingPartnerInfo:Boolean = false;
		
		/**
		 * since we only load partner info once, this flag indicates we already did so. 
		 */
		public var partnerInfoLoaded:Boolean = false;
		
		/**
		 * a flag indicating a call to export 2 csv is waiting for server response 
		 */
		public var processingCSVFlag:Boolean = false;
		

		//---------------------------------------------------------
		//singleton methods
		private static var _modelLocator:AnalyticsModelLocator;


		/**
		 * retreives an instance of the KMCModelLocator class
		 */
		public static function getInstance():AnalyticsModelLocator {
			if (_modelLocator == null) {
				_modelLocator = new AnalyticsModelLocator(new Enforcer());
			}

			return _modelLocator;
		}


		/**
		 * Disabled singleton constructor.
		 */
		public function AnalyticsModelLocator(enforcer:Enforcer) {
			context = new Context();
		}


		/**
		 * set value of loadingFlag according to the partial loading flags
		 */
		public function checkLoading():void {
			//trace(loadingChartFlag, loadingTableFlag, loadingTotalFlag, loadingEntryFlag, loadingBaseTotals, loadingPartnerInfo, loadingApplicationsFlag, processingCSVFlag);
			if (!loadingChartFlag && !loadingTableFlag && !loadingTotalFlag && 
				!loadingEntryFlag && !loadingBaseTotals && !loadingPartnerInfo && 
				!loadingApplicationsFlag && !processingCSVFlag) {
				this.loadingFlag = false;
			}
		}
	}
}

class Enforcer {

}
