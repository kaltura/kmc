package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.flavorAsset.FlavorAssetAdd;
	import com.kaltura.commands.flavorAsset.FlavorAssetSetContent;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaContentResource;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	public class AddFlavorCommand extends KedCommand {
		
		private var _resource:KalturaContentResource;
		
		override public function execute(event:KMvCEvent):void
		{
			_dispatcher = event.dispatcher;
			_model.increaseLoadCounter();
			var e:MediaEvent = event as MediaEvent;
			_resource = e.data.resource as KalturaContentResource;
			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset()
			flavorAsset.flavorParamsId = e.data.flavorParamsId;
			flavorAsset.setUpdatedFieldsOnly(true);
			flavorAsset.setInsertedFields(true);
			var fau:FlavorAssetAdd = new FlavorAssetAdd(e.entry.id, flavorAsset);
			fau.addEventListener(KalturaEvent.COMPLETE, setResourceContent);
			fau.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(fau);
		}
		
		protected function setResourceContent(e:KalturaEvent):void {
			super.result(e);
			var fasc:FlavorAssetSetContent = new FlavorAssetSetContent(e.data.id, _resource);
			fasc.addEventListener(KalturaEvent.COMPLETE, result);
			fasc.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(fasc);
		} 
		
		override public function result(data:Object):void {
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