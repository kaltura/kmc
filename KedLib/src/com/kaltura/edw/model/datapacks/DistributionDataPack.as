package com.kaltura.edw.model.datapacks
{
	import com.kaltura.edw.vo.DistributionProfileInfo;
	import com.kaltura.kmvc.model.IDataPack;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * information required for distribution of the current entry
	 * */
	public class DistributionDataPack implements IDataPack {
		
		public var shared:Boolean = false;
		
		/**
		 * contains all info regarding distribution profiles: distribution profiles and thumbnails 
		 */		
		public var distributionProfileInfo:DistributionProfileInfo = new DistributionProfileInfo();
		
		
		/**
		 * FlavorAssetWithParamsVO objects 
		 * used for entry drilldown > flavors, distribution
		 */		
		public var flavorParamsAndAssetsByEntryId:ArrayCollection = new ArrayCollection();
		
		/**
		 * Indicates whether flavors were loaded
		 * */
		public var flavorsLoaded:Boolean = false;
	}
}