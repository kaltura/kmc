package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetDelete;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class DeleteFlavorAssetCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var fap:KalturaFlavorAssetWithParams;
		override public function execute(event:CairngormEvent):void
		{		
			fap = event.data as KalturaFlavorAssetWithParams;
			Alert.show(ResourceManager.getInstance().getString('cms', 'deleteAssetMsg') + fap.flavorAsset.id + " ?", 
					   ResourceManager.getInstance().getString('cms', 'deleteAssetTitle'), Alert.YES | Alert.NO, null, handleUserResponse);
		
		}
		
		private function handleUserResponse(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				_model.increaseLoadCounter();
				var deleteCommand:FlavorAssetDelete = new FlavorAssetDelete(fap.flavorAsset.id);
	            deleteCommand.addEventListener(KalturaEvent.COMPLETE, result);
		        deleteCommand.addEventListener(KalturaEvent.FAILED, fault);
	    	    _model.context.kc.post(deleteCommand); 
			}
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
 			_model.decreaseLoadCounter();
 			Alert.show(ResourceManager.getInstance().getString('cms', 'assetDeletedMsg'), '', Alert.OK);
 			var entry:KalturaBaseEntry = new KalturaBaseEntry();
 			entry.id = fap.entryId;
 			var cgEvent : EntryEvent = new EntryEvent(EntryEvent.GET_FLAVOR_ASSETS, entry);
			cgEvent.dispatch();
		}
	}
}