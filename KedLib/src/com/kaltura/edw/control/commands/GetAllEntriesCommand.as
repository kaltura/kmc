package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryEvent;
	import com.kaltura.commands.mixing.MixingGetReadyMediaEntries;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class GetAllEntriesCommand extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();		
			var e : EntryEvent = event as EntryEvent;
			var getMediaReadyMix:MixingGetReadyMediaEntries = new MixingGetReadyMediaEntries(e.entryVo.id);
			
			getMediaReadyMix.addEventListener(KalturaEvent.COMPLETE, result);
			getMediaReadyMix.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(getMediaReadyMix);	 
		}
			
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
 			if(data.data && data.data is Array)
			{
				_model.entryDetailsModel.selectedEntry.parts = new ArrayCollection(data.data);
			}
			else
				trace("Error getting the list of roughcut entries"); 
		}
	}
}