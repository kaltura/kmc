package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.kmc.modules.content.vo.EntryMetadataDataVO;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data concerning entries details 
	 * @author Atar
	 */	
	public class EntryDetailsModel {
		/**
		 * list of Object {label}	<br>
		 * used for entry details window > entry metadata
		 * */
		public var categoriesFullNameList:ArrayCollection = new ArrayCollection();
		
		/**
		 * FlavorAssetWithParamsVO objects 
		 * used for entry drilldown > flavors, distribution
		 */		
		public var flavorParamsAndAssetsByEntryId:ArrayCollection = new ArrayCollection();
		
		
		/**
		 * total number of entries by current filter (the last ListEntriesCommand)
		 */		
		public var totalEntriesCount:int = 0;
		
		/**
		 * Current Viewed Entry
		 */
		public var selectedEntry:KalturaBaseEntry;
		
		/**
		 * will hold the metadata data values
		 * */
		public var metadataInfo:EntryMetadataDataVO;
		
		/**
		 * uiconf used with metadata
		 * */
		public var metadataDefaultUiconf:int;
		
		/**
		 * contains all info regarding distribution profiles: distribution profiles and thumbnails 
		 */		
		public var distributionProfileInfo:DistributionProfileInfo = new DistributionProfileInfo();
		
		/**
		 * indicates data is being retrieved from server at the moment 
		 */		
		public var loadingFlag:Boolean = false;
		/**
		 * R&P: whether to enable custom data update
		 */		
		public var enableUpdateMetadata:Boolean = true;
		
	}
}