package com.kaltura.edw.control.commands.clips
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.ClipsDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class ResetEntryClipsCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			(_model.getDataPack(ClipsDataPack) as ClipsDataPack).clips = null;
		}
	}
}