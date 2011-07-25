package com.kaltura.kmc.modules.content.commands.clips
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.baseEntry.BaseEntryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaBaseEntryFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class GetEntryClipsCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			var f:KalturaBaseEntryFilter = new KalturaBaseEntryFilter();
			f.rootEntryIdEqual = event.data.id;
			
			var list:BaseEntryList = new BaseEntryList(f, event.data.pager);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.COMPLETE, fault);
			_model.context.kc.post(list);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.entryDetailsModel.clips = data.data.objects;
		}
	}
}