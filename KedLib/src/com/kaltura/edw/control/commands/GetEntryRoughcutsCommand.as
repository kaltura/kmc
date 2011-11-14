package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.mixing.MixingGetMixesByMediaId;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.ContentDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;

	public class GetEntryRoughcutsCommand extends KedCommand 
	{
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();		
			var e : KedEntryEvent = event as KedEntryEvent;
			var getMixUsingEntry:MixingGetMixesByMediaId = new MixingGetMixesByMediaId(e.entryVo.id);
			
			getMixUsingEntry.addEventListener(KalturaEvent.COMPLETE, result);
			getMixUsingEntry.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(getMixUsingEntry);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if(data.data && data.data is Array) {
				var cdp:ContentDataPack = _model.getDataPack(ContentDataPack) as ContentDataPack;
				cdp.contentParts = data.data;
//				_model.entryDetailsModel.selectedEntry.dispatchEvent(new Event("partsChanged"));
			}
			else
				trace("Error getting the list of roughcut entries");
		}
	}
}