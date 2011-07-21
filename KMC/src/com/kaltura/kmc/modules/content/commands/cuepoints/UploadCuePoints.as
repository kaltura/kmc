package com.kaltura.kmc.modules.content.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.cuePoint.CuePointAddFromBulk;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	public class UploadCuePoints extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();		
			var cnt:CuePointAddFromBulk = new CuePointAddFromBulk(event.data);
			
			cnt.addEventListener(KalturaEvent.COMPLETE, result);
			cnt.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(cnt);	 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
		}
	}
}