package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.commands.flavorAsset.FlavorAssetDelete;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	
	public class DeleteFlavorAssetCommand extends KedCommand
	{
		private var fap:KalturaFlavorAssetWithParams;
		override public function execute(event:KMvCEvent):void
		{		
			_dispatcher = event.dispatcher;
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
	    	    _client.post(deleteCommand); 
			}
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
 			_model.decreaseLoadCounter();
 			Alert.show(ResourceManager.getInstance().getString('cms', 'assetDeletedMsg'), '', Alert.OK);
 			var entry:KalturaBaseEntry = new KalturaBaseEntry();
 			entry.id = fap.entryId;
 			var cgEvent : KedEntryEvent = new KedEntryEvent(KedEntryEvent.GET_FLAVOR_ASSETS, entry);
			_dispatcher.dispatch(cgEvent);
		}
	}
}