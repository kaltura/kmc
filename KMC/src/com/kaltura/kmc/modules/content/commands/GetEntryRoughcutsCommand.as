package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.mixing.MixingGetMixesByMediaId;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	
	import flash.events.Event;
	
	import mx.rpc.IResponder;

	public class GetEntryRoughcutsCommand extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();		
			var e : EntryEvent = event as EntryEvent;
			var getMixUsingEntry:MixingGetMixesByMediaId = new MixingGetMixesByMediaId(e.entryVo.id);
			
			getMixUsingEntry.addEventListener(KalturaEvent.COMPLETE, result);
			getMixUsingEntry.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(getMixUsingEntry);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if(data.data && data.data is Array) {
				_model.entryDetailsModel.contentParts = data.data;
//				_model.entryDetailsModel.selectedEntry.dispatchEvent(new Event("partsChanged"));
			}
			else
				trace("Error getting the list of roughcut entries");
		}
	}
}