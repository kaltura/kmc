package com.kaltura.kmc.modules.content.commands.live {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.types.KalturaConversionProfileType;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	[ResourceBundle("live")]
	
	public class ListLiveConversionProfilesCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			
			var p:KalturaFilterPager = new KalturaFilterPager();
			p.pageIndex = 1;
			p.pageSize = 500; // trying to get all conversion profiles here, standard partner has no more than 10
			var f:KalturaConversionProfileFilter = new KalturaConversionProfileFilter();
			f.typeEqual = KalturaConversionProfileType.LIVE_STREAM;
			var listProfiles:ConversionProfileList = new ConversionProfileList(f, p);
			listProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			listProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.increaseLoadCounter();
			_model.context.kc.post(listProfiles);
		}


		override public function result(data:Object):void {
			super.result(data);
			
			var result:Array = new Array();
			for each (var kcp:KalturaConversionProfile in (data.data as KalturaConversionProfileListResponse).objects) {
				if (kcp.isDefault == KalturaNullableBoolean.TRUE_VALUE) {
					result.unshift(kcp);
				}
				else {
					result.push(kcp);
				}
			}
			
			_model.liveConversionProfiles = new ArrayCollection(result);
			_model.decreaseLoadCounter();

		}
	}
}
