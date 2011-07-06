package com.kaltura.kmc.modules.content.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.cuePoint.CuePointCount;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CuePointEvent;
	import com.kaltura.vo.KalturaCuePointFilter;
	
	public class CountCuePoints extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();		
			var e : CuePointEvent = event as CuePointEvent;
			var f:KalturaCuePointFilter = new KalturaCuePointFilter();
			f.entryIdEqual = e.data;
			var cnt:CuePointCount = new CuePointCount(f);
			
			cnt.addEventListener(KalturaEvent.COMPLETE, result);
			cnt.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(cnt);	 
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			
			_model.entryDetailsModel.cuepointsCount = parseInt(data.data);
			 
		}
	}
}