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
		 * Indicates whtether flavors were loaded
		 * */
		public var flavorsLoaded:Boolean = false;
		
		/**
		 * total number of entries by current filter (the last ListEntriesCommand)
		 */		
		public var totalEntriesCount:int = 0;
		
		/**
		 * Current Viewed Entry
		 */
		public var selectedEntry:KalturaBaseEntry;
		
		/**
		 * array of EntryMetadataDataVO;
		 * */
		public var metadataInfoArray:ArrayCollection;
		
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
		
		/**
		 * a list of <code>ConversionProfileWithFlavorParamsVo</code> objects
		 * for each conversion profile, lists the flavorparams matching objects. 
		 */		
		public var conversionProfsWFlavorParams:ArrayCollection;
		
	}
}