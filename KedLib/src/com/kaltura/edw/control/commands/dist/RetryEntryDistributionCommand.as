package com.kaltura.edw.control.commands.dist
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionRetrySubmit;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.vo.KalturaEntryDistribution;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class RetryEntryDistributionCommand extends KalturaCommand
	{
		private var _entryDis:KalturaEntryDistribution;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_entryDis = (event as EntryDistributionEvent).entryDistribution;
			var retry:EntryDistributionRetrySubmit = new EntryDistributionRetrySubmit(_entryDis.id);
			retry.addEventListener(KalturaEvent.COMPLETE, result);
			retry.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(retry);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var updateResult:KalturaEntryDistribution = data.data as KalturaEntryDistribution;
			_entryDis.status = updateResult.status;

			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = _model.entryDetailsModel.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}