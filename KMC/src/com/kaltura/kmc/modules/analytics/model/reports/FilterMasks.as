package com.kaltura.kmc.modules.analytics.model.reports
{
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.DatesOnlyMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.DrillDownMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.PlatformMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.TopLevelMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.UnitsDatesMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.UnitsDatesUsersMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.UserEngDrillDownMask;
	import com.kaltura.kmc.modules.analytics.vo.filterMasks.UserEngMask;

	[Bindable]
	/**
	 * mapping of filter masks to reports.
	 * @see com.kaltura.kmc.modules.analytics.vo.filterMasks.BaseMask
	 * @author atar.shadmi
	 * 
	 */
	public class FilterMasks
	{
		
		private var _filterVo:FilterVo;
		
		// content
		public var topContent : FilterVo;
		public var topContentPerUser : FilterVo;
		public var contentDropoff : FilterVo;
		public var contentDropoffPerUser : FilterVo;
		public var contentInteraction : FilterVo;
		public var contentInteractionPerUser : FilterVo;
		public var contentContributions : FilterVo;
		
		// users
		public var topContrib : FilterVo;
		public var mapOverlay : FilterVo;
		public var syndicator : FilterVo;
		public var userEngagement : FilterVo;
		public var userEngagementDrilldown : FilterVo;
		
		// BW
		public var publisherBandwidthNStorage : FilterVo;
		public var endUserStorage : FilterVo;
		public var specificEndUserStorage : FilterVo;
		
		// Platform
		public var platforms : FilterVo;
		public var opsys : FilterVo;
		public var browsers : FilterVo;

		// Live
		public var liveContent : FilterVo;
		
		
		public function FilterMasks(fvo:FilterVo)
		{
			_filterVo = fvo;
			
			topContent = new TopLevelMask(fvo);
			topContentPerUser = new DrillDownMask(fvo);
			contentDropoff = new TopLevelMask(fvo);
			contentDropoffPerUser = new DrillDownMask(fvo);
			contentInteraction = new TopLevelMask(fvo);
			contentInteractionPerUser = new DrillDownMask(fvo);
			contentContributions = new DatesOnlyMask(fvo);
		
			topContrib = new DatesOnlyMask(fvo);
			mapOverlay = new DatesOnlyMask(fvo);
			syndicator = new DatesOnlyMask(fvo);
			userEngagement = new UserEngMask(fvo);
			userEngagementDrilldown = new UserEngMask(fvo);
			
			publisherBandwidthNStorage = new UnitsDatesMask(fvo);
			endUserStorage = new UnitsDatesUsersMask(fvo);
			specificEndUserStorage = new UnitsDatesUsersMask(fvo);
			
			platforms = new PlatformMask(fvo);
			opsys = new PlatformMask(fvo);
			browsers = new PlatformMask(fvo);
			
			liveContent = new TopLevelMask(fvo);
			
		}
		
		/**
		 * returns a reference to the actual filter object, not through any mask.
		 * USE CAREFULLY!! 
		 */		
		public function getExposedFilter():FilterVo {
			return _filterVo;
		}
		
	}
}