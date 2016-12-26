package com.kaltura.edw.control.commands {
	import com.kaltura.commands.liveStream.LiveStreamRegenerateStreamToken;
	import com.kaltura.edw.events.KedDataEvent;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;

	[ResourceBundle("live")]
	
	public class RegenerateLiveTokenCommand extends KedCommand {

		override public function execute(event:KMvCEvent):void {
			var regenerate:LiveStreamRegenerateStreamToken = new LiveStreamRegenerateStreamToken(event.data);
			regenerate.addEventListener(KalturaEvent.COMPLETE, result);
			regenerate.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_client.post(regenerate);
		}


		override public function result(data:Object):void {
			super.result(data);
			// update the new entry on the model (so in view)
			var e:KedDataEvent = new KedDataEvent(KedDataEvent.ENTRY_UPDATED);
			e.data = data.data; // send the updated entry as event data
			(_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher.dispatchEvent(e);
			
			_model.decreaseLoadCounter();

		}
	}
}
