package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.kmc.modules.content.vo.PartnerVO;
	import com.kaltura.vo.KalturaBaseSyndicationFeedFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data for external syndication tab 
	 * @author Atar
	 */	
	public class ExtSynModel {
		
		public var generalPlayListdata:ArrayCollection;
		
		/**
		 * data of current syndication
		 * */
		public var externalSyndications:ArrayCollection = new ArrayCollection();
		
		/**
		 * a list of players which can be used to display syndicated content.
		 * */
		[ArrayElementType("KalturaUiConf")]
		public var uiConfData:ArrayCollection = new ArrayCollection();
		
		public var syndicationFeedsFilterPager:KalturaFilterPager;
		
		public var syndicationFeedsFilter:KalturaBaseSyndicationFeedFilter;
		
		/**
		 * total number of syndication feeds for current partner
		 * */
		public var externalSyndicationFeedsTotalCount:int = 0;
		
		/**
		 * current partner's data
		 * */
		public var partnerData:PartnerVO = new PartnerVO();
		
		/**
		 * load partner info only once
		 * */
		public var partnerInfoLoaded:Boolean = false;
	}
}