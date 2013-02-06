package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.liveStream.LiveStreamAdd;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.kmc.modules.content.events.AddStreamEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaSourceType;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;

	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.vo.KalturaLiveStreamConfiguration;
	import com.kaltura.types.KalturaPlaybackProtocol;

	[ResourceBundle("live")]
	
	public class AddStreamCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			var sourceType:String = null;
			var streamVo:StreamVo = (event as AddStreamEvent).streamVo;
			var liveEntry:KalturaLiveStreamAdminEntry = new KalturaLiveStreamAdminEntry();
			liveEntry.mediaType = KalturaMediaType.LIVE_STREAM_FLASH;

			liveEntry.name = streamVo.streamName;
			liveEntry.description = streamVo.description;
			
			if (streamVo.streamType == StreamVo.STREAM_TYPE_LEGACY) {
				liveEntry.encodingIP1 = streamVo.primaryIp;
				liveEntry.encodingIP2 = streamVo.secondaryIp;	

				if (!streamVo.password)
					liveEntry.streamPassword = "";
				else
					liveEntry.streamPassword = streamVo.password;
			}
			else if (streamVo.streamType == StreamVo.STREAM_TYPE_UNIVERSAL) {
				liveEntry.encodingIP1 = streamVo.primaryIp;
				liveEntry.encodingIP2 = streamVo.secondaryIp;	
				
				if (!streamVo.password)
					liveEntry.streamPassword = "";
				else
					liveEntry.streamPassword = streamVo.password;
				
				sourceType = KalturaSourceType.AKAMAI_UNIVERSAL_LIVE;
			}
			else if (streamVo.streamType == StreamVo.STREAM_TYPE_MANUAL) {
				liveEntry.hlsStreamUrl = streamVo.mobileHLSURL;
				var cfg:KalturaLiveStreamConfiguration = new KalturaLiveStreamConfiguration();
				cfg.protocol = KalturaPlaybackProtocol.AKAMAI_HDS;
				cfg.url = streamVo.flashHDSURL;
				liveEntry.liveStreamConfigurations = [cfg];
				
				sourceType = KalturaSourceType.MANUAL_LIVE_STREAM;
			}

			var addEntry:LiveStreamAdd = new LiveStreamAdd(liveEntry, sourceType);
			addEntry.addEventListener(KalturaEvent.COMPLETE, result);
			addEntry.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.context.kc.post(addEntry);
		}


		override public function result(data:Object):void {
			super.result(data);
			Alert.show(ResourceManager.getInstance().getString('live', 'liveEntryTimeMessage'), ResourceManager.getInstance().getString('live', 'liveEntryTimeMessageTitle'));
			_model.decreaseLoadCounter();

			var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
			cgEvent.dispatch();

			var searchEvent2:SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
			KedController.getInstance().dispatch(searchEvent2);
		}
	}
}
