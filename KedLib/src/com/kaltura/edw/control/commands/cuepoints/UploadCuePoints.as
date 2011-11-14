package com.kaltura.edw.control.commands.cuepoints
{
	import com.kaltura.commands.cuePoint.CuePointAddFromBulk;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.CuePointsDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class UploadCuePoints extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			_model.increaseLoadCounter();		
			var cnt:CuePointAddFromBulk = new CuePointAddFromBulk(event.data);
			
			cnt.addEventListener(KalturaEvent.COMPLETE, result);
			cnt.addEventListener(KalturaEvent.FAILED, fault);
			cnt.queued = false;
			
			(_model.getDataPack(CuePointsDataPack) as CuePointsDataPack).reloadCuePoints = false;
			_client.post(cnt);	 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			//refresh cue points
			(_model.getDataPack(CuePointsDataPack) as CuePointsDataPack).reloadCuePoints = true;
			_model.decreaseLoadCounter();
		}
	}
}