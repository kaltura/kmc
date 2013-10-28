package com.kaltura.kmc.modules.content.commands.live {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.liveStream.LiveStreamAdd;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.AddStreamEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;
	import com.kaltura.types.KalturaConversionProfileType;
	import com.kaltura.types.KalturaDVRStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.types.KalturaPlaybackProtocol;
	import com.kaltura.types.KalturaSourceType;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaLiveStreamAdminEntry;
	import com.kaltura.vo.KalturaLiveStreamConfiguration;
	import com.kaltura.vo.KalturaLiveStreamEntry;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	[ResourceBundle("live")]
	
	public class ListLiveConversionProfilesCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			
			var p:KalturaFilterPager = new KalturaFilterPager();
			p.pageIndex = 1;
			p.pageSize = 500; // trying to get all conversion profiles here, standard partner has no more than 10
			var listProfiles:ConversionProfileList = new ConversionProfileList(null, p);
			listProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			listProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.context.kc.post(listProfiles);
		}


		override public function result(data:Object):void {
			super.result(data);
			
			var result:Array = new Array();
			for each (var kcp:KalturaConversionProfile in (data.data as KalturaConversionProfileListResponse).objects) {
				if (kcp.type == KalturaConversionProfileType.LIVE_STREAM) {
					result.push(kcp);
				}
			}
			
			_model.liveConversionProfiles = new ArrayCollection(result);
			_model.decreaseLoadCounter();

		}
	}
}
