package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.entryDistribution.EntryDistributionAdd;
	import com.kaltura.commands.entryDistribution.EntryDistributionDelete;
	import com.kaltura.commands.entryDistribution.EntryDistributionList;
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitAdd;
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitDelete;
	import com.kaltura.commands.entryDistribution.EntryDistributionUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryDistributionEvent;
	import com.kaltura.kmc.modules.content.model.EntryDistributionWithProfile;
	import com.kaltura.types.KalturaEntryDistributionStatus;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.vo.KalturaEntryDistributionFilter;
	import com.kaltura.vo.KalturaEntryDistributionListResponse;

	public class UpdateEntryDistributionsCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void 
		{
			var entryDistributionEvent:EntryDistributionEvent = event as EntryDistributionEvent;
			var distributionsToAdd:Array = entryDistributionEvent.distributionsWithProfilesToAddArray;
			var distributionsToRemove:Array = entryDistributionEvent.distributionsToRemoveArray;
			if (distributionsToAdd.length == 0 && distributionsToRemove.length == 0)
				return;
			
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			//all entry distributions to add
			var requestsIndex:int = 1;
			for each (var distribution:EntryDistributionWithProfile in distributionsToAdd) {
				//first delete old leftovers, create new entryDistribution if needed
				var addEntryDistribution:EntryDistributionAdd;
				if (distribution.kalturaEntryDistribution.status== KalturaEntryDistributionStatus.REMOVED) {
					var deleteEntryDistribution:EntryDistributionDelete = new EntryDistributionDelete(distribution.kalturaEntryDistribution.id);
					mr.addAction(deleteEntryDistribution);
					var newEntryDistribution:KalturaEntryDistribution = new KalturaEntryDistribution();
					newEntryDistribution.entryId = distribution.kalturaEntryDistribution.entryId;
					newEntryDistribution.distributionProfileId = distribution.kalturaEntryDistribution.distributionProfileId;
					addEntryDistribution = new EntryDistributionAdd(newEntryDistribution);
				}
				else {
					addEntryDistribution = new EntryDistributionAdd(distribution.kalturaEntryDistribution);
				}
				mr.addAction(addEntryDistribution);
				
				//if submitAdd action is required
				if (!distribution.manualQualityControl) {
					requestsIndex++;
					var submitEntry:EntryDistributionSubmitAdd = new EntryDistributionSubmitAdd(int.MIN_VALUE, true);
					mr.addAction(submitEntry);
					mr.addRequestParam(requestsIndex + ":id","{" + (requestsIndex-1) + ":result:id}");
				}
				requestsIndex++;
			}
			
			//all entry distributions to delete
			for each (var removeDistribution:KalturaEntryDistribution in distributionsToRemove) {
				//remove from destination
				if (removeDistribution.status == KalturaEntryDistributionStatus.READY ||
					removeDistribution.status == KalturaEntryDistributionStatus.ERROR_UPDATING) {
					var removeSubmitEntryDistribution:EntryDistributionSubmitDelete = new EntryDistributionSubmitDelete(removeDistribution.id);
					mr.addAction(removeSubmitEntryDistribution);	
				}
				//if entry wasn't submitted yet, delete it
				else if (removeDistribution.status == KalturaEntryDistributionStatus.QUEUED ||
						 removeDistribution.status == KalturaEntryDistributionStatus.PENDING ||
						 removeDistribution.status == KalturaEntryDistributionStatus.ERROR_SUBMITTING)
				{
					var deleteDistribution:EntryDistributionDelete = new EntryDistributionDelete(removeDistribution.id);
					mr.addAction(deleteDistribution);
				}
			}
			//get the new entry distributions list
			var entryDistributionFilter:KalturaEntryDistributionFilter = new KalturaEntryDistributionFilter();
			entryDistributionFilter.entryIdEqual = _model.entryDetailsModel.selectedEntry.id;	
			var listDistributions:EntryDistributionList = new EntryDistributionList(entryDistributionFilter);
			mr.addAction(listDistributions);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}
		
		override public function result(data:Object):void
		{
			_model.decreaseLoadCounter();
			super.result(data);
			var resultArray:Array = data.data as Array;
			var listDistributionsCommand:ListEntryDistributionCommand = new ListEntryDistributionCommand();
			listDistributionsCommand.handleEntryDistributionResult(resultArray[resultArray.length - 1] as KalturaEntryDistributionListResponse);
		}
	}
}