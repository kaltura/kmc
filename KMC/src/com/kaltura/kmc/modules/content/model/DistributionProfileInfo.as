package com.kaltura.kmc.modules.content.model
{
	import mx.collections.ArrayCollection;
	
	/**
	 * This class will hold information regarding distribution profiles.
	 * @author Michal
	 * 
	 */
	public class DistributionProfileInfo
	{
		//array of distribution profiels configured for current partner
		public var kalturaDistributionProfilesArrayCol:ArrayCollection;
		//array of thumbnail dimensions, required by the distribution profiles
		public var thumbnailDimensionsArrayCol:ArrayCollection;
		
		public function DistributionProfileInfo()
		{
			kalturaDistributionProfilesArrayCol = new ArrayCollection();
			thumbnailDimensionsArrayCol = new ArrayCollection();
			
		}
	}
}