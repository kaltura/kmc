package com.kaltura.edw.control.commands.dist
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionList;
	import com.kaltura.edw.control.commands.KalturaCommand;
	import com.kaltura.edw.model.EntryDistributionWithProfile;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.types.KalturaEntryDistributionStatus;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.vo.KalturaEntryDistributionFilter;
	import com.kaltura.vo.KalturaEntryDistributionListResponse;
	
	public class ListEntryDistributionCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var entryDistributionFilter:KalturaEntryDistributionFilter = new KalturaEntryDistributionFilter();
			entryDistributionFilter.entryIdEqual = _model.entryDetailsModel.selectedEntry.id;	
			var listEntryDistribution:EntryDistributionList = new EntryDistributionList(entryDistributionFilter);
			listEntryDistribution.addEventListener(KalturaEvent.COMPLETE, result);
			listEntryDistribution.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listEntryDistribution);

		}
		
		override public function result(data:Object):void
		{
			_model.decreaseLoadCounter();	
			super.result(data);

			var result:KalturaEntryDistributionListResponse = data.data as KalturaEntryDistributionListResponse;
			handleEntryDistributionResult(result);	
		}
		
		public function handleEntryDistributionResult(result:KalturaEntryDistributionListResponse):void 
		{
			var distributionArray:Array = new Array();
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray;
			for each (var distribution:KalturaEntryDistribution in result.objects) {
				if (distribution.status != KalturaEntryDistributionStatus.DELETED) {
					for each (var profile:KalturaDistributionProfile in profilesArray) {
						if (distribution.distributionProfileId == profile.id) {
							var newEntryDistribution:EntryDistributionWithProfile = new EntryDistributionWithProfile();
							newEntryDistribution.kalturaDistributionProfile = profile;
							newEntryDistribution.kalturaEntryDistribution = distribution;
							distributionArray.push(newEntryDistribution);
						} 
					}
				}
			}
			
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = distributionArray;
		}
	}
}