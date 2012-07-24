package com.kaltura.edw.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 * This class will hold information regarding distribution profiles.
	 * @author Michal
	 * 
	 */
	public class DistributionInfo
	{
		/**
		 * array of distribution profiels configured for current partner
		 * */
		public var distributionProfiles:Array;
		
		/**
		 * array of thumbnail dimensions, required by the distribution profiles
		 * */
		public var thumbnailDimensions:Array;
		
		public var entryDistributions:Array;
		
		public function DistributionInfo() {
			//			distributionProfiles = new Array();
			//			thumbnailDimensions = new Array();
			//			entryDistributions = new Array();
		}
	}
}