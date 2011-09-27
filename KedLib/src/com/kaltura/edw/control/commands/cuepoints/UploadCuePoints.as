package com.kaltura.edw.control.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.cuePoint.CuePointAddFromBulk;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class UploadCuePoints extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();		
			var cnt:CuePointAddFromBulk = new CuePointAddFromBulk(event.data);
			
			cnt.addEventListener(KalturaEvent.COMPLETE, result);
			cnt.addEventListener(KalturaEvent.FAILED, fault);
			cnt.queued = false;
			
			_model.entryDetailsModel.reloadCuePoints = false;
			_model.context.kc.post(cnt);	 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			//refresh cue points
			_model.entryDetailsModel.reloadCuePoints = true;
			_model.decreaseLoadCounter();
		}
	}
}