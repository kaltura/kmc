package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.flavorAsset.FlavorAssetSetContent;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaContentResource;
	
	public class UpdateFlavorCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			_dispatcher = event.dispatcher;
			_model.increaseLoadCounter();
			var e:MediaEvent = event as MediaEvent;
			var fau:FlavorAssetSetContent = new FlavorAssetSetContent(e.data.flavorAssetId, e.data.resource as KalturaContentResource);
			fau.addEventListener(KalturaEvent.COMPLETE, result);
			fau.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(fau);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			
			// to update the flavors tab, we re-load flavors data
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			if(edp.selectedEntry != null) {
				var cgEvent : KedEntryEvent = new KedEntryEvent(KedEntryEvent.GET_FLAVOR_ASSETS, edp.selectedEntry);
				_dispatcher.dispatch(cgEvent);
			}
		}
	}
}