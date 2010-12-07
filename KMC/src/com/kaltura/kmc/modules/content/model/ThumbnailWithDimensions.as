package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaThumbAsset;

	/**
	 * This class represents thumbnail dimensions. containes width, height, and which distribution profiles
	 * use these dimensions. 
	 * @author Michal
	 * 
	 */	
	public class ThumbnailWithDimensions
	{
		//the height of the thubnail
		public var height:int;
		//the width of the thumbnail
		public var width:int;
		//contains all distribution profiles that use these dimensions
		public var usedDistributionProfilesArray:Array;
		//represents the thumbnail asset
		public var thumbAsset:KalturaThumbAsset;
		
		
		/**
		 * Creates a new ThumbnailDimensions object 
		 * @param dimensionsWidth the width 
		 * @param dimensionsHeight the height
		 * @param thumbnailAsset is the thumbnail asset with the given dimensions. if this param is recieved, the given dimensionsWidth
		 * and dimensionsHeight params will be ignored
		 * 
		 */		
		public function ThumbnailWithDimensions(dimensionsWidth:int, dimensionsHeight:int, thumbnailAsset:KalturaThumbAsset = null)
		{
			if (thumbnailAsset) {
				thumbAsset = thumbnailAsset;
				width = thumbAsset.width;
				height = thumbAsset.height;
			}
			else {
				width = dimensionsWidth;
				height = dimensionsHeight;
			}
			usedDistributionProfilesArray = new Array();
		}
	}
}