package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.business.EntryUtil;
	import com.kaltura.vo.KalturaBaseEntry;

	public class UpdateEntryInListCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			//if in the entries list there's an entry with the same id, replace it.
			EntryUtil.updateSelectedEntryInList((event.data as KalturaBaseEntry), _model.listableVo.arrayCollection);
		}
	}
}