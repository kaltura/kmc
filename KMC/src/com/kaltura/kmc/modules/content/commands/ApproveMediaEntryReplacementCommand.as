package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaApproveReplace;
	import com.kaltura.controls.tabbar.OverlappingTabBar;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.business.Cloner;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.kmc.modules.content.utils.EntryUtil;
	import com.kaltura.vo.KalturaMediaEntry;

	public class ApproveMediaEntryReplacementCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var approveReplacement:MediaApproveReplace = new MediaApproveReplace((event as MediaEvent).entry.id);
			approveReplacement.addEventListener(KalturaEvent.COMPLETE, result);
			approveReplacement.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(approveReplacement);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (data.data && (data.data is KalturaMediaEntry)) {
				EntryUtil.updateChangebleFieldsOnly(data.data as KalturaMediaEntry);
				EntryUtil.updateSelectedEntryInList(_model.entryDetailsModel.selectedEntry);
			}
			else {
				trace ("error in approve replacement");
			}
			
			_model.decreaseLoadCounter();
		}
	}
}