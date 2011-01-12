package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionRetrySubmit;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryDistributionEvent;
	import com.kaltura.vo.KalturaEntryDistribution;

	public class RetryEntryDistributionCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var entryDis:KalturaEntryDistribution = (event as EntryDistributionEvent).entryDistribution;
			var retry:EntryDistributionRetrySubmit = new EntryDistributionRetrySubmit(entryDis.id);
			retry.addEventListener(KalturaEvent.COMPLETE, result);
			retry.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(retry);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = _model.entryDetailsModel.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}