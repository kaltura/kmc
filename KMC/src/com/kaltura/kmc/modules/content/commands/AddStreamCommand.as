package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.liveStream.LiveStreamAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.AddStreamEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.control.events.WindowEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaSourceType;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class AddStreamCommand extends KalturaCommand implements ICommand, IResponder
	{
		
		override public function execute(event:CairngormEvent):void
		{
			var streamVo:StreamVo = (event as AddStreamEvent).streamVo;
			
			//validation 
			if (!streamVo.streamName && !streamVo.primaryIp &&!streamVo.secondaryIp)
			{
				//failed 
				Alert.show(ResourceManager.getInstance().getString('cms', 'fillAllMandatory'));
				return;
			}
			
			var liveStremEntry:KalturaLiveStreamAdminEntry = new KalturaLiveStreamAdminEntry();
			
			liveStremEntry.name = streamVo.streamName;
			liveStremEntry.encodingIP1 = streamVo.primaryIp;
			liveStremEntry.encodingIP2 = streamVo.secondaryIp;
			
			if(streamVo.description)
				liveStremEntry.description = streamVo.description;
			if(!streamVo.password)
				liveStremEntry.streamPassword = "";
			else liveStremEntry.streamPassword = streamVo.password;

			liveStremEntry.mediaType = KalturaMediaType.LIVE_STREAM_FLASH;
												
			var addNewLiveStream:LiveStreamAdd = new LiveStreamAdd(liveStremEntry,KalturaSourceType.AKAMAI_LIVE);
            addNewLiveStream.addEventListener(KalturaEvent.COMPLETE,result);
	        addNewLiveStream.addEventListener(KalturaEvent.FAILED,fault);
	        _model.increaseLoadCounter();
    	    _model.context.kc.post(addNewLiveStream);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			Alert.show(ResourceManager.getInstance().getString('cms', 'liveEntryTimeMessage') , ResourceManager.getInstance().getString('cms', 'liveEntryTimeMessageTitle'));
	        _model.decreaseLoadCounter();
	        
        	var cgEvent : WindowEvent = new WindowEvent( WindowEvent.CLOSE );
			cgEvent.dispatch();	
	        
    		var searchEvent2 : SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo );
			searchEvent2.dispatch(); 
		}
	}
}