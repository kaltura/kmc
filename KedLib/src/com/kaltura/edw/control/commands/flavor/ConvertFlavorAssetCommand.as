package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.commands.flavorAsset.FlavorAssetConvert;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	public class ConvertFlavorAssetCommand extends KedCommand
	{
		private var selectedEntryId:String;
		override public function execute(event:KMvCEvent):void
		{	
			_dispatcher = event.dispatcher;
			_model.increaseLoadCounter();
			var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			selectedEntryId = obj.entryId;
			var convertCommand:FlavorAssetConvert = new FlavorAssetConvert(selectedEntryId, obj.flavorParams.id);
            convertCommand.addEventListener(KalturaEvent.COMPLETE, result);
	        convertCommand.addEventListener(KalturaEvent.FAILED, fault);
    	    _client.post(convertCommand);
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
 			_model.decreaseLoadCounter();
 			var entry:KalturaBaseEntry = new KalturaBaseEntry();
 			entry.id = selectedEntryId;
 			var cgEvent : KedEntryEvent = new KedEntryEvent(KedEntryEvent.GET_FLAVOR_ASSETS, entry);
			_dispatcher.dispatch(cgEvent);
		}
	}
}