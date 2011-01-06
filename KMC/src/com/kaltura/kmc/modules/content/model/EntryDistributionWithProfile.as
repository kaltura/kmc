package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaEntryDistribution;

	/**
	 * This class represents an entry distribution 
	 * @author Michal
	 * 
	 */	
	public class EntryDistributionWithProfile
	{
		/**
		 * describes the entry distribution 
		 */		
		public var kalturaEntryDistribution:KalturaEntryDistribution;
		/**
		 * describes the distribution profile for current entry distribution 
		 */		
		public var kalturaDistributionProfile:KalturaDistributionProfile;
		
		public function EntryDistributionWithProfile()
		{
		}
	}
}