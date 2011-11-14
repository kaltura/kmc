package com.kaltura.edw.control.commands.cuepoints {
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.CuePointsDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	

	public class ResetCuePointsCount extends KedCommand {

		override public function execute(event:KMvCEvent):void {
			(_model.getDataPack(CuePointsDataPack) as CuePointsDataPack).cuepointsCount = 0;
		}
	}
}