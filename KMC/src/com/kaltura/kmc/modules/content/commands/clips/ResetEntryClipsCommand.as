package com.kaltura.kmc.modules.content.commands.clips
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	public class ResetEntryClipsCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.entryDetailsModel.clips = null;
		}
	}
}