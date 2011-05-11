package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetSetContent;
	import com.kaltura.commands.flavorAsset.FlavorAssetUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.vo.KalturaContentResource;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	public class UpdateFlavorFromDropFolder extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var e:DropFolderFileEvent = event as DropFolderFileEvent;
			var fau:FlavorAssetSetContent = new FlavorAssetSetContent(e.data.flavorAssetId, e.resource as KalturaContentResource);
			fau.addEventListener(KalturaEvent.COMPLETE, result);
			fau.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(fau);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
		}
	}
}