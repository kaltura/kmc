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
		 * used for entry details window
		 * */
		public var categoriesFullNameList:ArrayCollection = new ArrayCollection();
		
		public var flavorParamsAndAssetsByEntryId:ArrayCollection = new ArrayCollection();
		
		
		/**
		 * total number of entries 
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
	}
}