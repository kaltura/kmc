package com.kaltura.kmc.modules.content.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	public class ResetCuePointsCount extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.entryDetailsModel.cuepointsCount = 0;
			
		}
	}
}