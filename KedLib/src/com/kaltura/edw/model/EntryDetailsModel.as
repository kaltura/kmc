package com.kaltura.edw.model
{
	import com.kaltura.edw.vo.CustomMetadataDataVO;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;
	import com.kaltura.edw.vo.DistributionInfo;

	[Bindable]
	/**
	 * data concerning entries details 
	 * @author Atar
	 */	
	public class EntryDetailsModel {
		
		/**
		 * total number of entries by current filter (the last ListEntriesCommand)
		 * (apparently this is only used in Entries class in content, and is not a part 
		 * of the drilldown. move it to another part of the model)
		 */		
		public var totalEntriesCount:int = 0;

		
		/**
		 * indicates data is being retrieved from server at the moment 
		 */		
		public var loadingFlag:Boolean = false;
		
	}
}