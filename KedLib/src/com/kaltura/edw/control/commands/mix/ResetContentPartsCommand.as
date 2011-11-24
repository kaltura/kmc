package com.kaltura.edw.control.commands.mix
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.ContentDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class ResetContentPartsCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
//			_model.increaseLoadCounter();		
			var cdp:ContentDataPack = _model.getDataPack(ContentDataPack) as ContentDataPack;
			cdp.contentParts = null;
//			
//			var e : KedEntryEvent = event as KedEntryEvent;
//			var getMixUsingEntry:MixingGetMixesByMediaId = new MixingGetMixesByMediaId(e.entryVo.id);
//			
//			getMixUsingEntry.addEventListener(KalturaEvent.COMPLETE, result);
//			getMixUsingEntry.addEventListener(KalturaEvent.FAILED, fault);
//			
//			_client.post(getMixUsingEntry);
		}
	}
}