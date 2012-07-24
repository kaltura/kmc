package com.kaltura.edw.control.commands.dist
{
	import com.kaltura.commands.entryDistribution.EntryDistributionList;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.EntryDistributionWithProfile;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaEntryDistributionStatus;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.vo.KalturaEntryDistributionFilter;
	import com.kaltura.vo.KalturaEntryDistributionListResponse;
	
	public class ListEntryDistributionCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			var entryDistributionFilter:KalturaEntryDistributionFilter = new KalturaEntryDistributionFilter();
			entryDistributionFilter.entryIdEqual = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry.id;	
			var listEntryDistribution:EntryDistributionList = new EntryDistributionList(entryDistributionFilter);
			listEntryDistribution.addEventListener(KalturaEvent.COMPLETE, result);
			listEntryDistribution.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(listEntryDistribution);

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
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			var distributionArray:Array = [];
			var profilesArray:Array = ddp.distributionInfo.distributionProfiles;
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
			
			ddp.distributionInfo.entryDistributions = distributionArray;
		}
	}
}