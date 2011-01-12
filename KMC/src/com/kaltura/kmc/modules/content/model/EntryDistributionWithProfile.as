package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaEntryDistribution;

	/**
	 * This class represents an entry distribution 
	 * @author Michal
	 * 
	 */	
	[Bindable]
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
		/**
		 * whether the entry will be automatic distributed or not 
		 * In case this value is true but the profile is configured otherwhise, this parameter has no meaning 
		 */		
		public var manualQualityControl:Boolean = true;
		public var updateRequired:Boolean = false;
		
		public function EntryDistributionWithProfile()
		{
		}
	}
}