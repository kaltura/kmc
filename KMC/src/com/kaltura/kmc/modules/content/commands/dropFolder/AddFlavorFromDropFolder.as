package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetAdd;
	import com.kaltura.commands.flavorAsset.FlavorAssetSetContent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.vo.KalturaContentResource;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	public class AddFlavorFromDropFolder extends KalturaCommand {
		
		private var _resource:KalturaContentResource;
		
		override public function execute(event:CairngormEvent):void
		{
			_resource = e.resource as KalturaContentResource;
			_model.increaseLoadCounter();
			var e:DropFolderFileEvent = event as DropFolderFileEvent;
			var flavorAsset:KalturaFlavorAsset = new KalturaFlavorAsset()
			flavorAsset.flavorParamsId = e.data.flavorParamsId;
			flavorAsset.setUpdatedFieldsOnly(true);
			flavorAsset.setInsertedFields(true);
			var fau:FlavorAssetAdd = new FlavorAssetAdd(e.entry.id, flavorAsset);
			fau.addEventListener(KalturaEvent.COMPLETE, result);
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
		}
		
		
	}
}