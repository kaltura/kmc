package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.DistributionProfileInfo;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaDistributionProfile;
	
	import mx.collections.ArrayCollection;

	public class ListDistributionProfilesCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			//!!!!erase later, just for testing
			_model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray = new Array();
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray;

			for (var i:int = 0; i<5; i++) {
				var bla:KalturaDistributionProfile = new KalturaDistributionProfile();
				bla.width = 400;
				bla.height = 300;
				bla.name = "NAME NAME " + i;
				profilesArray.push(bla);

		
			}
			
			var bla1:KalturaDistributionProfile = new KalturaDistributionProfile();
			bla1.width = 90;
			bla1.height = 90;
			bla1.name = "ProfileName";
			profilesArray.push(bla1);
			///erase later
		}
	}
}