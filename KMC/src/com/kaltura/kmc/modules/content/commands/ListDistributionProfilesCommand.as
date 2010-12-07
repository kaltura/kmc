package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.DistributionProfileInfo;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	
	import mx.collections.ArrayCollection;

	public class ListDistributionProfilesCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			trace ("will send distribution profiles list");
			//erase later, just for testing
			var dimensionsArray:ArrayCollection = _model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArrayCol;

			for (var i:int = 0; i<5; i++) {
				var dimensions:ThumbnailWithDimensions = new ThumbnailWithDimensions(1*i, 2*i);
				dimensions.usedDistributionProfilesArray = new Array("bla","bbbblllllllllllllllllllllllllllllllllllllllla", "michak");
				dimensionsArray.addItem(dimensions);
			}
		}
	}
}