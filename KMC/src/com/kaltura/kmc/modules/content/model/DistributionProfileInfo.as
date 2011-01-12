package com.kaltura.kmc.modules.content.model
{
	import mx.collections.ArrayCollection;
	
	/**
	 * This class will hold information regarding distribution profiles.
	 * @author Michal
	 * 
	 */
	[Bindable]
	public class DistributionProfileInfo
	{
		//array of distribution profiels configured for current partner
		private var _kalturaDistributionProfilesArray:Array;
		//array of thumbnail dimensions, required by the distribution profiles
		private var _thumbnailDimensionsArray:Array;
		private var _entryDistributionArray:Array;
	
		public function DistributionProfileInfo()
		{
			_kalturaDistributionProfilesArray = new Array();
			_thumbnailDimensionsArray = new Array();
			_entryDistributionArray = new Array();
			
		}
		

		public function get entryDistributionArray():Array
		{
			return _entryDistributionArray;
		}
		
		public function set entryDistributionArray(value:Array):void
		{
			_entryDistributionArray = value;
		}
		
		public function get thumbnailDimensionsArray():Array
		{
			return _thumbnailDimensionsArray;
		}
		
		public function set thumbnailDimensionsArray(value:Array):void
		{
			_thumbnailDimensionsArray = value;
		}
		
		public function get kalturaDistributionProfilesArray():Array
		{
			return _kalturaDistributionProfilesArray;
		}
		
		public function set kalturaDistributionProfilesArray(value:Array):void
		{
			_kalturaDistributionProfilesArray = value;
		}
		
	}
}