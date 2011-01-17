package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryDistributionEvent;
	import com.kaltura.vo.KalturaEntryDistribution;

	public class SubmitUpdateEntryDistributionCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var entryDis:KalturaEntryDistribution = (event as EntryDistributionEvent).entryDistribution;
			var update:EntryDistributionSubmitUpdate = new EntryDistributionSubmitUpdate(entryDis.id);
			update.addEventListener(KalturaEvent.COMPLETE, result);
			update.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(update);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = _model.entryDetailsModel.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}