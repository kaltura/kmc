package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.entryDistribution.EntryDistributionSubmitUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.types.KalturaEntryDistributionFlag;
	import com.kaltura.vo.KalturaEntryDistribution;

	public class SubmitUpdateEntryDistributionCommand extends KalturaCommand
	{
		private var _entryDis:KalturaEntryDistribution;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_entryDis = (event as EntryDistributionEvent).entryDistribution;
			var update:EntryDistributionSubmitUpdate = new EntryDistributionSubmitUpdate(_entryDis.id);
			update.addEventListener(KalturaEvent.COMPLETE, result);
			update.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(update);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var updateResult:KalturaEntryDistribution = data.data as KalturaEntryDistribution;
			_entryDis.status = updateResult.status;
			_entryDis.dirtyStatus = updateResult.dirtyStatus;
			//for data binding
			_model.entryDetailsModel.distributionProfileInfo.entryDistributionArray = _model.entryDetailsModel.distributionProfileInfo.entryDistributionArray.concat();
		}
	}
}