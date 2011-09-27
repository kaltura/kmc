package com.kaltura.edw.control.commands.clips
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class ResetEntryClipsCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.entryDetailsModel.clips = null;
		}
	}
}