package com.kaltura.kmc.modules.analytics.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.kaltura.KalturaClient;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.kmc.modules.analytics.model.reportdata.ReportData;
	import com.kaltura.kmc.modules.analytics.model.reports.AggregateHeaders;
	import com.kaltura.kmc.modules.analytics.model.reports.ReportDimension;
	import com.kaltura.kmc.modules.analytics.model.reports.TableHeaders;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.vo.AccountUsageVO;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	import com.kaltura.kmc.modules.analytics.vo.PartnerVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class AnalyticsModelLocator implements IModelLocator
	{
		
		/**
		 * the hour 23:59 in seconds
		 */		
		public const END_OF_DAY_IN_SECONDS : Number = 86399; 
		
		/**
		 * kaltura client that make all kaltura API calls
		 */		
		public var kc : KalturaClient; 
		
		/**
		 * application context data 
		 */		
		public var context : Context = null;
		
		//---------------------------------------------------------
		
		/**
		 * the uiconf that the loaded KDP uses 
		 */
		public var kdpUiConf:String;
		
		//---------------------------------------------------------
		//data objects
		private var _drillDownName : String = "";
		public function get drillDownName():String { return _drillDownName; }
		public function set drillDownName(str:String):void { 
			_drillDownName=str; 
		}
		public var reportDataMap : Object = new Object();
		
		/**
		 * data of currently shown report 
		 */
		public var selectedReportData : ReportData;
		public var partnerData : PartnerVO = new PartnerVO();
		public var usageData : AccountUsageVO = new AccountUsageVO();
		public var filter :FilterVo = new FilterVo();
		public var reportDimension : ReportDimension = new ReportDimension();
		public var aggregateHeaders : AggregateHeaders = new AggregateHeaders();
		public var tableHeaders : TableHeaders = new TableHeaders();
		public var selectedEntry : String;
		public var selectedUserId : String;
		public var tableSupportDrillDown : Boolean = true;
		public var showRefererIcon : Boolean = false;
		
		public var categories : Object = null;
		public var categoriesMap : HashMap = new HashMap();
		public var categoriesFullNameList : ArrayCollection  = new ArrayCollection();
		
		/**
		 * Set to enable disable entitlement feature in analytics
		 * and by that hide/show the relevent UI
		 */
		public var entitlementEnabled : Boolean = true;
		
		/**
		 * All the applications of the partner is listed here
		 */
		public var applicationsList : ArrayCollection = new ArrayCollection();
		
		/**
		 * dataprovider for content reports tab sub-navigation 
		 */		
		public var contentDtnDp : ArrayCollection = new ArrayCollection( 
										  [ ResourceManager.getInstance().getString('analytics','topContent') ,
										    ResourceManager.getInstance().getString('analytics','contentDropOff') ,
										    ResourceManager.getInstance().getString('analytics','contentInteractions') ,
										    ResourceManager.getInstance().getString('analytics','contentContributions') ]);
		
		/**
		 * dataprovider for the community reports tab sub-navigation 
		 */		
		public function get userDtnDp() : ArrayCollection {
			if(entitlementEnabled){
				return new ArrayCollection( 
					[ ResourceManager.getInstance().getString('analytics','topContributors') ,
						ResourceManager.getInstance().getString('analytics','mapOverlay') ,
						ResourceManager.getInstance().getString('analytics','topSyndications'),
						ResourceManager.getInstance().getString('analytics','userEngagement')]);
			}
			else
			{
				return new ArrayCollection( 
					[ ResourceManager.getInstance().getString('analytics','topContributors') ,
						ResourceManager.getInstance().getString('analytics','mapOverlay') ,
						ResourceManager.getInstance().getString('analytics','topSyndications')]);
			}
		}
		public var usageDtnDp : ArrayCollection = new ArrayCollection(
				[ 	ResourceManager.getInstance().getString('analytics', 'pbns')/*,
					ResourceManager.getInstance().getString('analytics', 'endUserStorage')*/]);
									 								 
	    //---------------------------------------------------------
		/**
		 * current showing screen, enumerated in <code>ScreenTypes</code>.
		 */	    
	    public var currentScreenState : int = ScreenTypes.TOP_CONTENT;
	    
		//---------------------------------------------------------
		//Flags 
		public var loadingFlag : Boolean = false;
		public var loadingChartFlag : Boolean = false;
		public var loadingTableFlag : Boolean = false;
		public var loadingTotalFlag : Boolean = false;
		public var loadingEntryFlag : Boolean = false;
		public var partnerInfoLoaded : Boolean = false;
		public var loadingApplicationsFlag : Boolean = false;
		
		//---------------------------------------------------------
		//singleton methods
		private static var _modelLocator : AnalyticsModelLocator;
		
		/**
		 * retreives an instance of the KMCModelLocator class 
		 */		
		public static function getInstance() : AnalyticsModelLocator
		{
			if ( _modelLocator == null )
			{
				_modelLocator = new AnalyticsModelLocator(new Enforcer());
			}

			return _modelLocator;
		}

		/**
		 * Disabled singleton constructor.
		 */		
		public function AnalyticsModelLocator(enforcer:Enforcer)
		{
			context = new Context();
		}
		
		/**
		 * set value of loadingFlag according to the partial loading flags
		 */		
		public function checkLoading() : void
		{
			if( !loadingChartFlag && !loadingTableFlag && !loadingTotalFlag && !loadingEntryFlag)
			{
				this.loadingFlag = false;
			}
		}
	}
}

class Enforcer
{
	
}