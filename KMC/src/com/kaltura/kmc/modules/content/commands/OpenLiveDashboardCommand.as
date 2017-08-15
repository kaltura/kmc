package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.kmc.modules.content.events.KMCEntryEvent;

	public class OpenLiveDashboardCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			(_model.entryDetailsModel.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry = (event as KMCEntryEvent).entryVo;
			_model.windowState = WindowsStates.LIVE_DASHBOARD;
		}
	}
}