package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.liveStream.LiveStreamIsLive;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.types.KalturaPlaybackProtocol;

	public class GetLivestreamStatusCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			if (event.type == KedEntryEvent.GET_LIVESTREAM_STATUS) {
				_model.increaseLoadCounter();
				var getStat:LiveStreamIsLive = new LiveStreamIsLive((event as KedEntryEvent).entryVo.id, KalturaPlaybackProtocol.HDS); 
				getStat.addEventListener(KalturaEvent.COMPLETE, result);
				getStat.addEventListener(KalturaEvent.FAILED, fault);
				_client.post(getStat);
			}
			else if (event.type == KedEntryEvent.RESET_LIVESTREAM_STATUS) {
				var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
				edp.selectedLiveEntryIsLive = KalturaNullableBoolean.NULL_VALUE;
			}
		}
		
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data); // look for server errors
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			//data.data is "0" | "1"  
			edp.selectedLiveEntryIsLive = data.data;
		}
	}
}