package com.kaltura.edw.control.commands.dist
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.edw.control.commands.KalturaCommand;


	public class SubmitEntryDistributionCommand extends KalturaCommand
	{
		private var _entryDis:KalturaEntryDistribution;
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			_entryDis = (event as EntryDistributionEvent).entryDistribution;
			var submit:EntryDistributionSubmitAdd = new EntryDistributionSubmitAdd(_entryDis.id);
			submit.addEventListener(KalturaEvent.COMPLETE, result);
			submit.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(submit);
		}
		
		override public function result(data:Object):void 
		{
			_model.decreaseLoadCounter();
			super.result(data);
			var resultEntry:KalturaEntryDistribution = data.data as KalturaEntryDistribution;
			_entryDis.status =  resultEntry.status;
			_entryDis.dirtyStatus = resultEntry.dirtyStatus;
			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = _model.entryDetailsModel.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}