package com.kaltura.edw.control.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class ResetCuePointsCount extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.entryDetailsModel.cuepointsCount = 0;
			
		}
	}
}