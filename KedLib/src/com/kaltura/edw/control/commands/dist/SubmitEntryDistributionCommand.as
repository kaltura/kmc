package com.kaltura.edw.control.commands.dist
{
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitAdd;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaEntryDistribution;


	public class SubmitEntryDistributionCommand extends KedCommand
	{
		private var _entryDis:KalturaEntryDistribution;
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();
			_entryDis = (event as EntryDistributionEvent).entryDistribution;
			var submit:EntryDistributionSubmitAdd = new EntryDistributionSubmitAdd(_entryDis.id);
			submit.addEventListener(KalturaEvent.COMPLETE, result);
			submit.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(submit);
		}
		
		override public function result(data:Object):void 
		{
			_model.decreaseLoadCounter();
			super.result(data);
			var resultEntry:KalturaEntryDistribution = data.data as KalturaEntryDistribution;
			_entryDis.status =  resultEntry.status;
			_entryDis.dirtyStatus = resultEntry.dirtyStatus;
			//for data binding
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			ddp.distributionProfileInfo.entryDistributionArray = ddp.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}