package com.kaltura.kmc.modules.content.commands.live {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.liveStream.LiveStreamAdd;
	import com.kaltura.edw.control.DataTabController;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.control.events.ModelEvent;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.AddStreamEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaDVRStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaPlaybackProtocol;
	import com.kaltura.types.KalturaRecordStatus;
	import com.kaltura.types.KalturaSourceType;
	import com.kaltura.vo.KalturaLiveStreamConfiguration;
	import com.kaltura.vo.KalturaLiveStreamEntry;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	[ResourceBundle("live")]
	
	public class AddStreamCommand extends KalturaCommand {

		private var _sourceType:String = null;
		
		private var _createdEntryId:String;
		
		
		
		override public function execute(event:CairngormEvent):void {
			var streamVo:StreamVo = (event as AddStreamEvent).streamVo;
			var liveEntry:KalturaLiveStreamEntry = new KalturaLiveStreamEntry();
			liveEntry.mediaType = KalturaMediaType.LIVE_STREAM_FLASH;

			liveEntry.name = streamVo.streamName;
			liveEntry.description = streamVo.description;
			
			if (streamVo.streamType == StreamVo.STREAM_TYPE_LEGACY) {
				setAkamaiLegacyParams(liveEntry, streamVo);
			}
			else if (streamVo.streamType == StreamVo.STREAM_TYPE_UNIVERSAL) {
				setAkamaiUniversalParams(liveEntry, streamVo);
				_sourceType = KalturaSourceType.AKAMAI_UNIVERSAL_LIVE;
			}
			else if (streamVo.streamType == StreamVo.STREAM_TYPE_MANUAL) {
				setManualParams(liveEntry, streamVo);
				_sourceType = KalturaSourceType.MANUAL_LIVE_STREAM;
			}
			else if (streamVo.streamType == StreamVo.STREAM_TYPE_KALTURA) {
				setKalturaLiveParams(liveEntry, streamVo);
				_sourceType = KalturaSourceType.LIVE_STREAM;
			}

			var addEntry:LiveStreamAdd = new LiveStreamAdd(liveEntry, _sourceType);
			addEntry.addEventListener(KalturaEvent.COMPLETE, result);
			addEntry.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.context.kc.post(addEntry);
		}
		
		
		/**
		 * set parameters relevant to Kaltura live streams 
		 * @param liveEntry	entry to manipulate
		 * @param streamVo	data
		 */
		private function setKalturaLiveParams(liveEntry:KalturaLiveStreamEntry, streamVo:StreamVo):void {
			// dvr
			if (streamVo.dvrEnabled) {
				liveEntry.dvrStatus = KalturaDVRStatus.ENABLED;
				liveEntry.dvrWindow = 30;
			}
			else {
				liveEntry.dvrStatus = KalturaDVRStatus.DISABLED;
			}
			// recording
			if (streamVo.recordingEnabled) {
				liveEntry.recordStatus = KalturaRecordStatus.ENABLED;
			}
			else {
				liveEntry.recordStatus = KalturaRecordStatus.DISABLED;
			}
			
			liveEntry.conversionProfileId = streamVo.conversionProfileId;
		}
		
		
		/**
		 * set parameters relevant to manual live streams 
		 * @param liveEntry	entry to manipulate
		 * @param streamVo	data
		 */
		private function setManualParams(liveEntry:KalturaLiveStreamEntry, streamVo:StreamVo):void {
			liveEntry.hlsStreamUrl = streamVo.mobileHLSURL;
			var cfg:KalturaLiveStreamConfiguration = new KalturaLiveStreamConfiguration();
			cfg.protocol = KalturaPlaybackProtocol.AKAMAI_HDS;
			cfg.url = streamVo.flashHDSURL;
			liveEntry.liveStreamConfigurations = [cfg];
		}
		
		
		/**
		 * set parameters relevant to Akamai universal live streams 
		 * @param liveEntry	entry to manipulate
		 * @param streamVo	data
		 */
		private function setAkamaiUniversalParams(liveEntry:KalturaLiveStreamEntry, streamVo:StreamVo):void {
			liveEntry.encodingIP1 = streamVo.primaryIp;
			liveEntry.encodingIP2 = streamVo.secondaryIp;
			
			if (streamVo.dvrEnabled) {
				liveEntry.dvrStatus = KalturaDVRStatus.ENABLED;
				liveEntry.dvrWindow = 30;
			}
			else {
				liveEntry.dvrStatus = KalturaDVRStatus.DISABLED;
			}
			
			if (!streamVo.password)
				liveEntry.streamPassword = "";
			else
				liveEntry.streamPassword = streamVo.password;
		}		
		
		
		/**
		 * set parameters relevant to Akamai legacy live streams 
		 * @param liveEntry	entry to manipulate
		 * @param streamVo	data
		 */
		private function setAkamaiLegacyParams(liveEntry:KalturaLiveStreamEntry, streamVo:StreamVo):void {
			liveEntry.encodingIP1 = streamVo.primaryIp;
			liveEntry.encodingIP2 = streamVo.secondaryIp;	
			
			if (!streamVo.password)
				liveEntry.streamPassword = "";
			else
				liveEntry.streamPassword = streamVo.password;
		}
		


		override public function result(data:Object):void {
			super.result(data);
			_createdEntryId = (data.data as KalturaLiveStreamEntry).id;
			var rm:IResourceManager = ResourceManager.getInstance();
			if (_sourceType == KalturaSourceType.MANUAL_LIVE_STREAM) {
				Alert.show(rm.getString('live', 'manualLiveEntryCreatedMessage', [_createdEntryId]), rm.getString('live', 'manualLiveEntryCreatedMessageTitle'));
			}
			else if (_sourceType == KalturaSourceType.LIVE_STREAM) {
				showKalturaLiveCreaetedMessage();
			}
			else {
				Alert.show(rm.getString('live', 'liveEntryTimeMessage'), rm.getString('live', 'liveEntryTimeMessageTitle'));
			}
			
			_model.decreaseLoadCounter();

			var cgEvent:WindowEvent = new WindowEvent(WindowEvent.CLOSE);
			cgEvent.dispatch();

			var searchEvent2:SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES, _model.listableVo);
			KedController.getInstance().dispatch(searchEvent2);
		}
		
		
		private function showKalturaLiveCreaetedMessage():void {
			var rm:IResourceManager = ResourceManager.getInstance();
			Alert.cancelLabel = rm.getString('live', 'goto_entry');
			Alert.show(rm.getString('live', 'kalturaLiveEntryCreatedMessage'), rm.getString('live', 'liveEntryTimeMessageTitle'), Alert.OK|Alert.CANCEL, null, gotoEntry);
			Alert.cancelLabel = rm.getString('live', 'cancel');
		}
		
		private function gotoEntry(event:CloseEvent):void {
			if (event.detail == Alert.CANCEL) {
				var cg:KMvCEvent = new ModelEvent(ModelEvent.DUPLICATE_ENTRY_DETAILS_MODEL);
				DataTabController.getInstance().dispatch(cg);
				cg = new KedEntryEvent(KedEntryEvent.GET_ENTRY_AND_DRILLDOWN, null, _createdEntryId);
				DataTabController.getInstance().dispatch(cg);
			}
		}
	}
}
