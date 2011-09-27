package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaCancelReplace;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.business.Cloner;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.kmc.modules.content.utils.EntryUtil;
	import com.kaltura.vo.KalturaMediaEntry;


	public class CancelMediaEntryReplacementCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var cancelReplacement:MediaCancelReplace = new MediaCancelReplace((event as MediaEvent).entry.id);
			cancelReplacement.addEventListener(KalturaEvent.COMPLETE, result);
			cancelReplacement.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(cancelReplacement);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && (data.data is KalturaMediaEntry)) {
				EntryUtil.updateChangebleFieldsOnly(data.data as KalturaMediaEntry);
				EntryUtil.updateSelectedEntryInList(_model.entryDetailsModel.selectedEntry);
			}
			else {
				trace ("error in cancel replacement");
			}
			
			_model.decreaseLoadCounter();
		}
	}
}