package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.EntryEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetConvert;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import mx.rpc.IResponder;
	
	public class ConvertFlavorAssetCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var selectedEntryId:String;
		override public function execute(event:CairngormEvent):void
		{	
			_model.increaseLoadCounter();
			var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			selectedEntryId = obj.entryId;
			var convertCommand:FlavorAssetConvert = new FlavorAssetConvert(selectedEntryId, obj.flavorParams.id);
            convertCommand.addEventListener(KalturaEvent.COMPLETE, result);
	        convertCommand.addEventListener(KalturaEvent.FAILED, fault);
    	    _model.context.kc.post(convertCommand);
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
 			_model.decreaseLoadCounter();
 			var entry:KalturaBaseEntry = new KalturaBaseEntry();
 			entry.id = selectedEntryId;
 			var cgEvent : EntryEvent = new EntryEvent(EntryEvent.GET_FLAVOR_ASSETS, entry);
			cgEvent.dispatch();
		}
	}
}