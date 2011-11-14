package com.kaltura.edw.control.commands.cuepoints
{
	import com.kaltura.commands.cuePoint.CuePointCount;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.CuePointEvent;
	import com.kaltura.edw.model.datapacks.CuePointsDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaCuePointFilter;
	
	public class CountCuePoints extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();		
			var e : CuePointEvent = event as CuePointEvent;
			var f:KalturaCuePointFilter = new KalturaCuePointFilter();
			f.entryIdEqual = e.data;
			var cnt:CuePointCount = new CuePointCount(f);
			
			cnt.addEventListener(KalturaEvent.COMPLETE, result);
			cnt.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(cnt);	 
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			
			(_model.getDataPack(CuePointsDataPack) as CuePointsDataPack).cuepointsCount = parseInt(data.data);
			 
		}
	}
}