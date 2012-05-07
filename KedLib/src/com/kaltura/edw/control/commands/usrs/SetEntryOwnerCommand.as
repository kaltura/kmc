package com.kaltura.edw.control.commands.usrs
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaUser;
	
	public class SetEntryOwnerCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			edp.selectedEntryOwner = event.data as KalturaUser;
		}
	}
}