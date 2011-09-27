package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetAdd;
	import com.kaltura.commands.flavorAsset.FlavorAssetSetContent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.DropFolderFileEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.edw.control.events.MediaEvent;
	import com.kaltura.vo.KalturaContentResource;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	public class AddFlavorCommand extends KalturaCommand {
		
		private var _resource:KalturaContentResource;
		
		override public function execute(event:CairngormEvent):void
		{
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
			_model.context.kc.post(fau);
		}
		
		protected function setResourceContent(e:KalturaEvent):void {
			super.result(e);
			var fasc:FlavorAssetSetContent = new FlavorAssetSetContent(e.data.id, _resource);
			fasc.addEventListener(KalturaEvent.COMPLETE, result);
			fasc.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(fasc);
		} 
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			// to update the flavors tab, we re-load flavors data
			if(_model.entryDetailsModel.selectedEntry != null) {
				var cgEvent : EntryEvent = new EntryEvent(EntryEvent.GET_FLAVOR_ASSETS, _model.entryDetailsModel.selectedEntry);
				cgEvent.dispatch();
			}
		}
		
		
	}
}